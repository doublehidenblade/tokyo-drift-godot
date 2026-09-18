extends Node2D
## Tiny pseudo-3D road renderer spike (Godot 4, GDScript).
## Classic segment-projection approach: the same math any engine needs,
## hosted here in Godot instead of a JS canvas. Auto-drives, snaps
## screenshots to /tmp/tdgodot/, then quits.

const VW := 960.0
const VH := 540.0
const SEG_LEN := 200
const RUMBLE_LEN := 3
const DRAW_DIST := 200
const CAM_DEPTH := 0.84
const CAM_HEIGHT := 1150.0
const ROAD_W := 2100.0
const LANES := 3

var segments: Array = []
var track_length := 0.0
var track_pos := 0.0
var speed := 0.0
var max_speed := SEG_LEN * 55.0
var player_x := 0.0
var drive_t := 0.0
var elapsed := 0.0
var shot_times := [1.5, 4.0, 8.0, 12.0]
var shot_idx := 0
var font: Font
var rng := RandomNumberGenerator.new()


func _ready() -> void:
	font = ThemeDB.fallback_font
	rng.seed = 7
	build_road()
	track_length = float(segments.size() * SEG_LEN)
	DirAccess.make_dir_recursive_absolute("/tmp/tdgodot")


func ease_in(a: float, b: float, p: float) -> float:
	return a + (b - a) * p * p


func ease_out(a: float, b: float, p: float) -> float:
	return a + (b - a) * (1.0 - (1.0 - p) * (1.0 - p))


func add_segment(curve: float, y: float) -> void:
	var n := segments.size()
	segments.append({
		"index": n,
		"curve": curve,
		"y1": y,
		"y2": y,
		"sprites": [],
		"light": (n / RUMBLE_LEN) % 2 == 0,
	})


func add_road(enter: int, hold: int, leave: int, curve: float, dy: float) -> void:
	var start_y: float = segments[segments.size() - 1]["y2"] if segments.size() > 0 else 0.0
	var end_y := start_y + dy * SEG_LEN
	var total := float(enter + hold + leave)
	for i in range(enter):
		add_segment(curve * ease_in(0.0, 1.0, float(i) / float(enter)),
			lerpf(start_y, end_y, float(i) / total))
	for i in range(hold):
		add_segment(curve, lerpf(start_y, end_y, float(enter + i) / total))
	for i in range(leave):
		add_segment(curve * ease_out(1.0, 0.0, float(i) / float(leave)),
			lerpf(start_y, end_y, float(enter + hold + i) / total))


func build_road() -> void:
	add_road(40, 40, 40, 0.0, 0.0)
	add_road(30, 30, 30, 2.0, 25.0)
	add_road(40, 40, 40, 0.0, -12.0)
	add_road(30, 30, 30, -3.0, 35.0)
	add_road(40, 40, 40, 0.0, -48.0)
	add_road(30, 30, 30, 4.0, 0.0)
	for i in range(0, segments.size(), 10):
		segments[i]["sprites"].append({"kind": "tree", "offset": -1.7 - rng.randf() * 1.4})
		if i % 20 == 0:
			segments[i]["sprites"].append({"kind": "tree", "offset": 1.7 + rng.randf() * 1.4})
	for i in range(30, segments.size(), 110):
		segments[i]["sprites"].append({"kind": "sign", "offset": 1.35})


func find_segment(z: float) -> Dictionary:
	return segments[int(floor(z / SEG_LEN)) % segments.size()]


func project(world_x: float, world_y: float, world_z: float,
		cam_x: float, cam_y: float, cam_z: float) -> Dictionary:
	var scale := CAM_DEPTH / maxf(world_z - cam_z, 0.0001)
	return {
		"x": VW / 2.0 + scale * (world_x - cam_x) * VW / 2.0,
		"y": VH / 2.0 - scale * (world_y - cam_y) * VH / 2.0,
		"w": scale * ROAD_W * VW / 2.0,
		"scale": scale,
		"z": world_z - cam_z,
	}


func _process(delta: float) -> void:
	elapsed += delta
	drive_t += delta
	speed = minf(speed + max_speed * delta * 0.55, max_speed)
	track_pos = fmod(track_pos + speed * delta, track_length)
	player_x = 0.55 * sin(drive_t * 0.45)
	queue_redraw()
	if shot_idx < shot_times.size() and elapsed >= shot_times[shot_idx]:
		shot_idx += 1
		snap("shot%d.png" % shot_idx)
	if elapsed > 14.0:
		get_tree().quit()


func snap(name: String) -> void:
	await RenderingServer.frame_post_draw
	var img := get_viewport().get_texture().get_image()
	var err := img.save_png("/tmp/tdgodot/" + name)
	print("snap ", name, " err=", err)


func quad(x1: float, y1: float, x2: float, y2: float,
		x3: float, y3: float, x4: float, y4: float, col: Color) -> void:
	draw_colored_polygon(PackedVector2Array(
		[Vector2(x1, y1), Vector2(x2, y2), Vector2(x3, y3), Vector2(x4, y4)]), col)


func _draw() -> void:
	draw_sky()
	var base := find_segment(track_pos)
	var base_pct := fmod(track_pos, SEG_LEN) / SEG_LEN
	var pseg := find_segment(track_pos + CAM_HEIGHT * CAM_DEPTH)
	var player_pct := fmod(track_pos + CAM_HEIGHT * CAM_DEPTH, SEG_LEN) / SEG_LEN
	var player_y: float = lerpf(pseg["y1"], pseg["y2"], player_pct)
	var maxy := VH
	var x := 0.0
	var dx := -float(base["curve"]) * base_pct
	for n in range(DRAW_DIST):
		var seg: Dictionary = segments[(int(base["index"]) + n) % segments.size()]
		var looped: bool = int(seg["index"]) < int(base["index"])
		var cam_z := track_pos - (track_length if looped else 0.0)
		var p1 := project(0.0, seg["y1"], float(seg["index"]) * SEG_LEN,
			player_x * ROAD_W - x, player_y + CAM_HEIGHT, cam_z)
		var p2 := project(0.0, seg["y2"], float(seg["index"] + 1) * SEG_LEN,
			player_x * ROAD_W - x - dx, player_y + CAM_HEIGHT, cam_z)
		x += dx
		dx += float(seg["curve"])
		if p1["z"] <= CAM_DEPTH or p2["y"] >= p1["y"] or p2["y"] >= maxy:
			continue
		draw_road_seg(p1, p2, seg)
		draw_seg_sprites(seg, p1)
		maxy = p1["y"]
	draw_player()
	draw_hud()


func draw_sky() -> void:
	var top := Color(0.24, 0.44, 0.86)
	var bot := Color(0.74, 0.86, 0.97)
	for i in range(12):
		draw_rect(Rect2(0, i * VH / 24.0, VW, VH / 24.0 + 1.0),
			top.lerp(bot, float(i) / 11.0))
	draw_circle(Vector2(VW * 0.78, VH * 0.15), 34.0, Color(1.0, 0.95, 0.62))
	# distant hills
	draw_colored_polygon(PackedVector2Array([Vector2(0, VH / 2.0), Vector2(VW * 0.2, VH * 0.36),
		Vector2(VW * 0.45, VH / 2.0)]), Color(0.36, 0.5, 0.42))
	draw_colored_polygon(PackedVector2Array([Vector2(VW * 0.4, VH / 2.0), Vector2(VW * 0.62, VH * 0.33),
		Vector2(VW * 0.85, VH / 2.0)]), Color(0.33, 0.47, 0.4))


func draw_road_seg(p1: Dictionary, p2: Dictionary, seg: Dictionary) -> void:
	var light: bool = seg["light"]
	var grass := Color(0.36, 0.63, 0.29) if light else Color(0.33, 0.59, 0.26)
	var road := Color(0.43, 0.43, 0.45) if light else Color(0.40, 0.40, 0.42)
	var rumble := Color(0.85, 0.16, 0.16) if light else Color(0.93, 0.93, 0.93)
	quad(0, p2["y"], 0, p1["y"], VW, p1["y"], VW, p2["y"], grass)
	var r1: float = p1["w"] * 1.18
	var r2: float = p2["w"] * 1.18
	quad(p1["x"] - r1, p1["y"], p1["x"] - p1["w"], p1["y"],
		p2["x"] - p2["w"], p2["y"], p2["x"] - r2, p2["y"], rumble)
	quad(p1["x"] + p1["w"], p1["y"], p1["x"] + r1, p1["y"],
		p2["x"] + r2, p2["y"], p2["x"] + p2["w"], p2["y"], rumble)
	quad(p1["x"] - p1["w"], p1["y"], p1["x"] + p1["w"], p1["y"],
		p2["x"] + p2["w"], p2["y"], p2["x"] - p2["w"], p2["y"], road)
	if light:
		for l in range(1, LANES):
			var lx1: float = p1["x"] - p1["w"] + 2.0 * p1["w"] * l / LANES
			var lx2: float = p2["x"] - p2["w"] + 2.0 * p2["w"] * l / LANES
			var lw1: float = p1["w"] * 0.025
			var lw2: float = p2["w"] * 0.025
			quad(lx1 - lw1, p1["y"], lx1 + lw1, p1["y"],
				lx2 + lw2, p2["y"], lx2 - lw2, p2["y"], Color(0.95, 0.95, 0.95))


func draw_seg_sprites(seg: Dictionary, p1: Dictionary) -> void:
	for sp in seg["sprites"]:
		var s: float = p1["scale"]
		var sx: float = p1["x"] + s * float(sp["offset"]) * ROAD_W * VW / 2.0
		var sy: float = p1["y"]
		if sx < -200.0 or sx > VW + 200.0:
			continue
		if sp["kind"] == "tree":
			var h := s * 3200.0 * VH / 2.0
			var w := h * 0.42
			draw_rect(Rect2(sx - w * 0.08, sy - h * 0.45, w * 0.16, h * 0.45),
				Color(0.32, 0.22, 0.13))
			draw_circle(Vector2(sx, sy - h * 0.62), w * 0.5, Color(0.16, 0.42, 0.2))
			draw_circle(Vector2(sx - w * 0.22, sy - h * 0.5), w * 0.34, Color(0.13, 0.36, 0.17))
		elif sp["kind"] == "sign":
			var h := s * 2200.0 * VH / 2.0
			var w := h * 1.6
			draw_rect(Rect2(sx - w * 0.04, sy - h, w * 0.08, h), Color(0.25, 0.25, 0.28))
			draw_rect(Rect2(sx - w / 2.0, sy - h * 1.9, w, h * 0.9), Color(0.12, 0.3, 0.75))
			draw_rect(Rect2(sx - w / 2.0, sy - h * 1.9, w, h * 0.9), Color(1, 1, 1), false, 2.0)


func draw_player() -> void:
	var cx := VW / 2.0 + player_x * 60.0
	var cy := VH - 118.0
	var w := 118.0
	var h := 62.0
	# shadow
	fill_ellipse(Vector2(cx, cy + h * 0.62), w * 1.05, 14.0, Color(0, 0, 0, 0.35))
	# wheels
	draw_rect(Rect2(cx - w, cy - h * 0.25, w * 0.28, h * 0.5), Color(0.08, 0.08, 0.1))
	draw_rect(Rect2(cx + w * 0.72, cy - h * 0.25, w * 0.28, h * 0.5), Color(0.08, 0.08, 0.1))
	# body
	draw_colored_polygon(PackedVector2Array([Vector2(cx - w * 0.92, cy + h * 0.5),
		Vector2(cx - w * 0.72, cy - h * 0.28), Vector2(cx + w * 0.72, cy - h * 0.28),
		Vector2(cx + w * 0.92, cy + h * 0.5)]), Color(0.78, 0.1, 0.12))
	# cockpit
	draw_colored_polygon(PackedVector2Array([Vector2(cx - w * 0.34, cy - h * 0.2),
		Vector2(cx - w * 0.26, cy - h * 0.62), Vector2(cx + w * 0.26, cy - h * 0.62),
		Vector2(cx + w * 0.34, cy - h * 0.2)]), Color(0.1, 0.12, 0.2))
	# spoiler
	draw_rect(Rect2(cx - w * 0.95, cy - h * 0.72, w * 1.9, h * 0.16), Color(0.6, 0.08, 0.1))
	# tail lights
	draw_rect(Rect2(cx - w * 0.8, cy + h * 0.3, w * 0.3, h * 0.14), Color(1.0, 0.85, 0.2))
	draw_rect(Rect2(cx + w * 0.5, cy + h * 0.3, w * 0.3, h * 0.14), Color(1.0, 0.85, 0.2))


func fill_ellipse(center: Vector2, rx: float, ry: float, col: Color) -> void:
	var pts := PackedVector2Array()
	for i in range(20):
		var a := TAU * i / 20.0
		pts.append(center + Vector2(cos(a) * rx, sin(a) * ry))
	draw_colored_polygon(pts, col)


func draw_hud() -> void:
	var kmh := int(speed / SEG_LEN * 36.0)
	draw_string(font, Vector2(16, 34), "%d km/h" % kmh, HORIZONTAL_ALIGNMENT_LEFT, -1, 26, Color.WHITE)
	draw_string(font, Vector2(16, 64), "GODOT 4 SPIKE — pseudo-3D road",
		HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(1, 1, 1, 0.8))
