# Tokyo Drift — TRACK_ANGLES.md (chase-cam framing notes, v1)

Practical camera notes for 4 key circuit sections. Assumes a standard chase cam:
~8 m behind the car, ~3.5 m above the road surface, looking ~30–50 m ahead.
All positions are world meters (see CITY_LAYOUT.md). `+lat` = driver's left.

## 1. Start/finish straight (s 4941 → 5227 → 0 → 470)

- **Framing:** Wide, stable, near-level. The straight runs ~470 m north (+Z) from the
  gantry at (0,0,0) with almost no curvature — the chase cam barely swings. Good place
  for the "hero" framing: gantry overhead at the line, pit lane (driver's left,
  lat +18…+32) visible at frame left on laps 2+.
- **Sightlines / wayfinding:** Start Plaza mid-rise blocks (8–20 m) frame both sides;
  the elevated expressway deck (y=15, orange edge strips) crosses overhead at s=869 and
  reads as the "end of the straight" landmark from the line. Harbor West warehouse
  rooftops + container stacks beyond.
- **Camera-collision concerns:** None significant — buildings hold |latF| ≥ 18 m
  (class (a) shells per the SCENE_DESIGN.md classification table), cam
  swing stays within ~5 m lateral here. Keep the gantry crossbeam above y=7 so the cam
  (≤ ~4.5 m) never clips it at the line.

## 2. Bridge crossing (s 1502–2285)

- **Framing:** The money shot. Deck climbs y 11 → 20 (apex s=1899 at (822,1440)) → 14
  over 783 m. Let the cam drop slightly lower (~3 m) and widen the FOV a touch on the
  span so the water reads on both sides. Tower portal frames at s=1600 (531,1379) and
  s=2200 (1114,1380) are drive-through moments — columns at ±17 m lateral, crossbeams
  high above (~40 m over deck): the car and cam pass *through* the frame, never under
  a low beam.
- **Sightlines / wayfinding:** Main cables converge toward the apex — a natural
  vanishing-point guide. Far north shore (z≈2260): 4 port cranes with orange beacons
  + industrial skyline silhouette = the "you're crossing the bay" landmark. Warren
  truss + suspenders below the deck edges frame the lower third of the shot.
- **Camera-collision concerns:** Tower columns at ±17 m are the only near-track
  structure; on the curved bridge entries the chase cam swings outward — clamp cam
  lateral offset to < 14 m through s 1550–1650 and s 2150–2250 so it can't clip a
  column. Suspenders/truss are at/below deck level, outside the cam's vertical band.
  (Classification: the bridge leg is class (b) — open both sides, no shells to hit;
  far shores are class (c) cards, never geometry.)

## 3. Downtown gauntlet (s 2573–3573)

- **Framing:** Tightest cam work on the lap. S-curves around s≈2925 (cp8 (1390,740))
  with towers 35–70 m on both sides — keep the cam close (~7 m) and let it swing with
  the car; the buildings at |latF| ≥ 18 m form a neon canyon without entering the
  frame edges. Dense facade signage is the texture here, not landmarks.
- **Sightlines / wayfinding:** The air-train rail (y=13) crosses overhead twice —
  s=2535 (north edge, clearance ~6.3 m) right at downtown entry and s=3203 (south edge,
  clearance ~12.7 m). The rail + a passing 4-car train is the recurring "you are
  downtown" beat. Tower clusters: keep one extra-tall signature tower (~70 m) on the
  outside of the s≈2925 S-curve as the turn-in reference.
- **Camera-collision concerns:** (a) Clamp chase-cam lateral swing to < 15 m through
  the whole downtown section — 18 m building setback minus cam swing leaves margin,
  but banking + drift can push the car 8–10 m out, so the cam must not add more.
  (Class (a) shells on both sides here; anything beyond |lat| 60 m is class (c)
  backdrop cards, never geometry.)
  (b) Air-train pylons (1.5 m dia, every 30 m) near the two crossings: keep pylons
  ≥ 10 m from the centerline at s 2535 and s 3203 so a wide cam swing can't clip one.
  (c) The rail itself at 6.3 m clearance over a 6.7 m-high track point — cam at ~3.5 m
  above road passes under cleanly; do NOT raise the cam on the entry straight.

## 4. Tunnel run (s 3533–4318)

- **Framing:** Entry portal at s=3570 (1340,117), headwall faces +Z (north) toward the
  driver; exit portal at s=4278 (860,-330), headwall faces +X (east). The tube is
  curved — the exit is NOT visible from the entry (mid s=3937 at (1168,-202)). Frame
  the approach so the concrete headwall + "トンネル TUNNEL" board + recessed edge
  strips fill the frame for ~1 s before entry: that's the wayfinding. Inside, the
  strip/sconce rhythm + 8 point lights carry the shot (tunnel-only ambient, never
  black). Exit: daylight bloom + the Industrial Edge chimney silhouettes.
- **Sightlines / wayfinding:** Retaining walls run 40 m out from each portal
  (entry s 3530–3570, exit s 4278–4318) — they funnel the eye into the bore. Ridge
  hills flank the tube and read as dark-blue masses above the headwalls.
- **Camera-collision concerns:** (a) Ridge hill blobs start at |lat| = 30 m and the
  tube is never covered (M4 fix) — but on the curved approach the chase cam swings
  wide; clamp cam lateral to < 20 m through s 3500–3600 and s 4250–4320. (The
  portal corridors are class (b) — designed open, no shells; no class (a) buildings
  exist on the ridge legs.) (b) Keep cam
  height ≤ 4 m above road through both 40 m retaining-wall zones so the near plane
  can't clip the headwall top beam on entry/exit transitions. (c) No scenery inside
  the tube within ±12 m lateral of the centerline — the bore is only as wide as it is.
