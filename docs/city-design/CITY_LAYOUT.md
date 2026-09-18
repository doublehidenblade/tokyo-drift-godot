# Tokyo Drift — CITY_LAYOUT.md (2D city planning spec, v1)

Text rebuild spec for the Godot city builder. All coordinates are **world-space meters**,
XZ plane unless noted; Y is height. Coordinate convention: **+X = east, +Z = north** on
planning maps (screen: +X right, +Z up); **+Y = up**. Angles in radians unless noted.

## 0. Sources & corrections vs the brief

- Track truth: `~/workspace/tokyo-drift-3d/src/track.js` control points, sampled with the
  real Catmull-Rom spline (length **5227.05 m**). Every waypoint in §8 was computed from
  the actual spline, not estimated — the builder can trust these numbers.
- **Correction:** the brief said start/finish heads "roughly +X". The real spline at s=0
  has tangent **(-0.462, 0, 0.887)** — i.e. it heads **+Z (north)**, veering slightly -X
  as it closes the loop from cp14. By s≈100 it is pure +Z. All layout below uses the real
  +Z heading.
- District s-ranges are from CITY_PLAN.md (unchanged). World rects below were fitted to
  the real spline positions at those s-boundaries.
- Track-space convention (from track.js): `s` = meters along lap, `+lat` = driver's LEFT.

## 1. Global anchors

| Item | Value |
|---|---|
| Lap length | 5227.05 m |
| Circuit bbox | x ∈ [-27, 1392], z ∈ [-336, 1440] |
| Start/finish | (0, 0, 0), gantry yaw -0.480 rad, heading +Z |
| Bay water rect | x ∈ [500, 1180], z ∈ [1000, 2260], surface y = -5 |
| Map planning frame (for the concept map) | x ∈ [-400, 1700], z ∈ [-600, 2400] |

## 2. District boundaries (world XZ)

Rects are inclusive. Where a district overlaps the bay rect, **water wins** (no buildings
in water; piers/quays excepted).

| # | District | s-range | World rect (x0,x1,z0,z1) | Character / heights |
|---|---|---|---|---|
| 1 | Start Plaza | 4941→5227→0→470 | (-220, 320, -260, 560) | Mid-rise commercial, 8–20 m. Start gantry at (0,0,0). |
| 2 | Harbor West | 470–1235 | (-260, 470, 400, 1300) | Warehouses 6–12 m, container stacks, cargo props. Borders bay west shore (x=500). |
| 3 | The Climb | 1235–1502 | (150, 560, 1080, 1440) | Hillside mixed mid-rise 10–25 m. NE corner overlaps bay rect → shoreline there. |
| 4 | Bay Strait (water) | 1502–2285 | (500, 1180, 1000, 2260) | Open water, y=-5. Bridge crosses at z≈1330–1440. |
| 5 | Waterfront East | 2285–2573 | (1140, 1500, 980, 1420) | Promenade, low commercial, piers. Piers extend west into bay (see §5). |
| 6 | Downtown | 2573–3573 | (1040, 1520, 60, 1120) | Neon core, towers 35–70 m, densest signage. Air-train loop inside. |
| 7 | South Ridge | 3533–4318 | (740, 1440, -440, 220) | Ridge hills flank tunnel tube; portals §4. |
| 8 | Industrial Edge | 4318–4941 | (80, 940, -460, -60) | Warehouses, chimneys w/ beacons, container yards, sodium-orange accents. |

## 3. Bay, shoreline, port

- Water: rect x ∈ [500, 1180], z ∈ [1000, 2260], surface y = -5.
- West shore: x = 500 line (Harbor West side), z ∈ [1000, 1300] is the visible shore near the
  track; quay wall along x=500, z ∈ [1300, 2260].
- East shore: x = 1180 line (Waterfront East side); promenade + quay, z ∈ [1000, 1420].
- South mouth: z = 1000 line, x ∈ [500, 1180] — open water continues south off-map.
- Far north shore: quay wall along z = 2260, x ∈ [500, 1180].
- Port cranes (4, procedural, orange beacons, ~60 m tall) at:
  (560, 2240), (740, 2240), (920, 2240), (1100, 2240).
- Industrial silhouette skyline: boxes 20–45 m tall, z ∈ [2280, 2400], x ∈ [520, 1160]
  (background only, ≥300 m from track per B1).

## 4. Suspension bridge (s 1502–2285)

- West abutment: s=1502 → (443.2, 11.2, 1336.4). Deck y ≈ 11.
- Leaves land (bay west shore x=500): s=1566 → (500, 12.7, 1365.5).
- **Tower T1:** s=1600 → center (531.2, 1379.1), deck y ≈ 13.6.
- **Tower T2:** s=2200 → center (1113.7, 1380.0), deck y ≈ 16.4.
- Suspended span (tower to tower): **583 m** over water.
- Apex: s=1899 → (822.0, 20.0, 1440.0) — 25 m above water.
- Reaches land (bay east shore x=1180): s=2284.2 → (1180, 14.3, 1328.7).
- East abutment / leg end: s=2285 → (1180.6, 14.3, 1328.1). Deck y ≈ 14.
- Tower spec (each): portal frame — 2 columns at **lateral ±17 m** from centerline,
  2 crossbeams + X-bracing, blue-lit. Main cables run EXACTLY over column tops
  (cable lateral = tower lateral = 17 m; saddle blocks at contact).
- Warren stiffening truss under both deck edges between towers + suspenders cable→deck;
  deck girder box under road ribbon; railing posts unified with guard-rail system.

## 5. Tunnel (s 3533–4318, through South Ridge)

- **Entry portal:** s=3570.1 → (1339.5, -2.0, 117.2). Tangent (-0.170, -0.005, -0.985):
  headwall plane faces **+Z (north)**, toward the oncoming driver.
- **Exit portal:** s=4278.3 → (860.4, -3.0, -329.9). Tangent (-0.989, 0.005, -0.150):
  headwall plane faces **+X (east)**.
- Tube: sealed, y ≈ -2..-3, curved (mid s=3937.5 → (1167.5, -3.0, -202.3)).
- Portals: concrete headwalls (side pylons + top beam), "トンネル TUNNEL" board on beam,
  recessed emissive edge strips.
- Retaining walls: 40 m out from each portal → entry s ∈ [3530, 3570], exit s ∈ [4278, 4318].
- Ridge hills: flank tube at |lat| ∈ [30, 90] m, **never over the tube**. Blob centers
  (world XZ), radius 35–55 m, peak height 25–45 m, base y≈0:
  - s=3650: (1371.7, 24.9) / (1268.5, 59.9)
  - s=3800: (1302.4, -121.7) / (1209.8, -64.4)
  - s=3950: (1196.0, -249.6) / (1125.6, -166.5)
  - s=4100: (1052.3, -333.8) / (1011.2, -232.9)
  - s=4250: (898.1, -378.8) / (877.8, -271.7)

## 6. Elevated expressway

- Straight deck: centerline z = 860, x ∈ [-300, 1100], deck y = 15, deck width 22 m.
- Pillars every 40 m at (x, 860), x = -280 … 1080 (35 pillars), 2.5×2.5 m, y 0→13.5.
- Edge light strips both edges; ~24 animated car-light dots, both directions.
- Crosses OVER the circuit at s=869.3 → (50.0, 1.0, 858.8): **14 m clearance**.
- Crosses Quay Blvd at (-160, 860): grade-separated (expressway y=15 over road y=0).

## 7. Air-train

- Rounded-rect loop: straights x=1120 / x=1520 for z ∈ [560, 1040], and z=480 / z=1120
  for x ∈ [1200, 1440]; corner radius 80 m. Rail y = 13, guideway width 6 m.
- Pylons every 30 m along loop (~65 pylons), 1.5 m diameter, y 0→12.
- One 4-car train looping at 22 m/s.
- Crosses OVER the circuit twice:
  - #1: s=2535.1 → (1316.9, 6.7, 1120.0), loop north edge. Clearance ≈ 6.3 m.
  - #2: s=3202.6 → (1299.1, 0.3, 480.0), loop south edge. Clearance ≈ 12.7 m.
- Buildings skip a 14 m corridor (±7 m) around the rail path.

## 8. Circuit key waypoints (from the real spline)

| s (m) | x | y | z | Note |
|---|---|---|---|---|
| 0 | 0.0 | 0.0 | 0.0 | START/FINISH gantry |
| 250 | -22.5 | 0.1 | 246.0 | pit exit |
| 470 | -0.3 | 0.0 | 465.4 | → Harbor West |
| 869.3 | 50.0 | 1.0 | 858.8 | expressway crossing |
| 1235 | 233.1 | 5.1 | 1173.4 | → The Climb |
| 1502 | 443.2 | 11.2 | 1336.4 | bridge west abutment |
| 1600 | 531.2 | 13.6 | 1379.1 | bridge tower T1 |
| 1899 | 822.0 | 20.0 | 1440.0 | bridge apex |
| 2200 | 1113.7 | 16.4 | 1380.0 | bridge tower T2 |
| 2285 | 1180.6 | 14.3 | 1328.1 | bridge east abutment |
| 2535.1 | 1316.9 | 6.7 | 1120.0 | air-train crossing #1 |
| 2573 | 1331.9 | 5.9 | 1085.3 | → Downtown |
| 2925.6 | 1390.0 | 2.0 | 740.0 | downtown core (S-curves) |
| 3202.6 | 1299.1 | 0.3 | 480.0 | air-train crossing #2 |
| 3533 | 1342.4 | -1.8 | 156.6 | tunnel leg start |
| 3570.1 | 1339.5 | -2.0 | 117.2 | TUNNEL ENTRY portal |
| 3937.5 | 1167.5 | -3.0 | -202.3 | tunnel mid |
| 4278.3 | 860.4 | -3.0 | -329.9 | TUNNEL EXIT portal |
| 4318 | 820.6 | -2.7 | -334.3 | tunnel leg end → Industrial Edge |
| 4592.2 | 550.0 | 0.0 | -300.0 | climbing sweeper |
| 4850 | 311.2 | 0.9 | -203.6 | pit entry |
| 4941.6 | 230.5 | 1.0 | -160.3 | → Start Plaza |

## 9. Pit area

- Pit lane (track space): s ∈ [4850, 5227] ∪ [0, 250], lateral **+18 m (inner) to +32 m
  (outer)** — driver's LEFT side.
- Pit entry s=4850 → world ≈ (311, -204); pit exit s=250 → world ≈ (-22, 246).
- 12 pit boxes, 12 m each, along the outer edge (lat +26…+32).
- Reference world bbox: x ∈ [-25, 330], z ∈ [-210, 250] (lane follows the curve).

## 10. Arterial road grid (world segments; [x0,z0]→[x1,z1], width m)

Global rules: no arterial crosses the circuit at grade (stubs terminate ≥25 m from the
centerline); arterials keep ≥25 m from the centerline everywhere; bridge/tunnel legs
have no at-grade junctions.

- **Start Plaza:** Foundry Ave [(-140,-260)→(-140,560)] w14; Gantry Row W [(-220,60)→(-40,60)] w10; Gantry Row E [(60,60)→(320,60)] w10.
- **Harbor West:** Quay Blvd [(-160,400)→(-160,1300)] w16; Container Way [(380,900)→(380,1300)] w12; Crane St W [(-260,700)→(-60,700)] w10; Crane St E [(140,700)→(380,700)] w10.
- **The Climb:** Switchback Ln [(120,1050)→(120,1330)] w10.
- **Waterfront East:** Shoreline Ave [(1450,980)→(1450,1420)] w12; Pier Rd [(1180,1420)→(1500,1420)] w10. Piers (decks y=-2, 90×14 m, jutting west into bay): z=1100, 1180, 1260, x ∈ [1060, 1180].
- **Downtown:** Neon Ave [(1060,80)→(1060,1120)] w14; Center Dori [(1210,207)→(1210,473)] w10 (new; stub south of air-train corridor); Sakura Dori [(1067,660)→(1300,660)] w10 (new; stub, ends ≥60 m west of circuit centerline at z=660); Shibuya St [(1060,900)→(1095,900)] w10 (stub, ends 25 m west of rail corridor); Dori Ave [(1060,200)→(1210,200)] w12. Yokocho Alley [(1260,207)→(1260,473)] w4 pedestrian (new; splits Center Court block — the Japanese alley texture layer).
- **South Ridge:** Ridge Rd [(1450,-440)→(1450,220)] w10; Portal Rd [(1100,200)→(1280,200)] w10.
- **Industrial Edge:** Furnace Rd [(80,-420)→(940,-420)] w14; Stack Ave [(950,-460)→(950,-60)] w12; Yard Rd [(120,-460)→(120,-60)] w10.

## 11. Builder clearance rules (from CITY_PLAN.md, binding)

- Buildings: |latF| ≥ 18 m; HARD build-time audit — project every footprint corner to
  track space, THROW if any corner is inside roadHalf + 2.5 m.
- Hills (general): ≥150 m from track; mountains ≥300 m, dark-blue emissive lift (never
  pitch black). Ridge hills: per §5 only.
- Neon signs: facade-mounted ONLY (vertical signboards + horizontal boards, back-box
  hardware sunk into walls). No floating signs.
- Streetlights every 30 m (teal heads); power poles with sagging catenary wires.
- Water reflection streaks ONLY under registered light sources.

## 13. Sightline-class builder rules (keyed to METHODOLOGY.md §3)

Binding geometry budgets per sightline class. Class zones are assigned per
district section in SCENE_DESIGN.md ("Sightline classification" table); the
rules below are what each class is allowed to cost.

### Class (a) — facade shells (blocked by 1–2 building layers)

- **Shell depth cap: 2 layers or |lat| ≤ 60 m, whichever is nearer.** Beyond
  that the zone is class (c) — never extend shells into backdrop depth.
- Shells are front + side faces only: no interiors, no backsides (back walls
  may be omitted entirely; if a back face can catch a camera at a corner, use
  one flat quad).
- Clearance: |latF| ≥ 18 m to shell faces (§11 audit applies — audit the shell
  faces, not phantom backs).
- Rooftop dressing (penthouse/parapet units) on shells ONLY where the roofline
  reads from track elevation (bridge deck, downtown tiers, sentō chimney view
  lines); flat un-dressed roofs elsewhere.
- Facade-mounted signage layer is mandatory on Tier 1 district shells; designed
  stencils/shutters/wall-lamps on Tier 2 shells. Unfinished (a) shells are
  missing their signage, not their polys.

### Class (b) — intentional open areas (plazas, waterfronts, portal corridors)

- Full designed content: ground plane, props, planters, railings, registered
  light sources, landmarks as real geometry.
- **Sightline corridors inside (b) zones stay clear to ±12 m lateral** of the
  corridor the camera looks down (portals, gantry apron, pier walkways);
  furniture and props live outside that corridor band.
- Open ≠ empty: a (b) zone with bare ground fails audit — every open zone has
  its designed-content checklist in its district section.

### Class (c) — distant backdrop (2D silhouettes only)

- **NEVER geometry.** Backdrop planes / silhouette strips only.
- **Backdrop plane distances: 300–900 m from the nearest track point.** Planes
  closer than 300 m parallax-break on corners; planes farther than 900 m fall
  off the planning frame (x ∈ [-400,1700], z ∈ [-600,2400]).
- Height bands: skyline strips 20–45 m (industrial silhouette, §3), landmark
  cards up to 90 m (port cranes at 60 m). Dark-blue emissive lift, never pitch
  black (standing rule).
- Existing anchors obey this rule today: industrial silhouette skyline at
  z ∈ [2280,2400] is ≥300 m from the bridge leg (B1 note); keep future
  backdrops at ≥300 m too.

### Cross-class checks (build-time audits)

1. Shell-depth audit: sample any (a) zone — no mesh face may exist at |lat| >
   60 m unless the zone's table row says (c) there. Violation = demote to (c)
   card or delete.
2. Backdrop audit: no 3D geometry may carry a class-(c) zone tag.
3. Openness audit: every (b) row in the classification table must have its
   designed-content items placed — empty (b) zones are the one failure mode
   the camera cannot forgive.

## 14. Downtown block structure (informed by PLANNING_LANGUAGE.md)

Block-first planning per the reference language (PLANNING_LANGUAGE.md): ~80–150 m
superblocks bounded by arterials (§10); blocks assemble **snap-together from a
modular part kit** (podium band / tower shaft / setback tier / rooftop unit /
parapet). District composition follows the Midtown pattern: a **tight
tower-in-plaza highrise cluster ringed by 5–10 storey mid-rise blocks** — towers
sit BACK inside their blocks with hardscaped plaza at their feet (never filled to
the lot lines); the mid-rise fabric builds to the block edges around them.
Vertical layering on every block: **1–2 storey commercial podium / retail
frontage** (lit shopfronts, kanban) → shaft → **rooftop penthouse / mechanical
units** (each roof a different combination — no bare roofs, the cheapest skyline
variation). Landmarks at vista termini on the driver's sightline. Block rects are
world XZ, inclusive. All blocks obey §11 (B3 clearance, 14 m air-train corridor) —
corner coordinates below are pre-audit targets, not exemptions.

**Downtown street treatment:** signalized intersections with **zebra crossings**
on the arterial approaches — Neon Ave × Dori Ave (1060,200), Neon Ave × Sakura
Dori (1060,660), Neon Ave × Shibuya St (1060,900); **Japanese-style gantry
signals** on Neon Ave at (1060,660) and (1060,900); pole-mounted signal heads at
all three junctions. Street trees in planters along both Neon Ave edges.
**Green strips at the district edge:** planted seating pocket along the Dori Ave
south edge (x 1067–1300, z 60–67, part of South Gate block) and plaza trees at
the Spire Block tower setbacks.

West column (x ≤ 1300), east faces driver toward the S-curves:
| Block | Rect (x0,x1,z0,z1) | Content |
|---|---|---|
| Neon Corner | (1067,1113,207,473) | 25–40 m towers; densest kanban frontage on Neon Ave (west face) |
| Center Court | (1215,1258,207,473) + (1262,1300,207,473) | 15–25 m shotengai/service fabric, split by Yokocho Alley (x=1260 w4, lanterns, vending) |
| Shibuya Block | (1067,1113,487,653) | 20–35 m; faces air-train south corridor |
| Sakura Block | (1067,1113,667,893) | 20–35 m mid-rise fabric |
| Neon North | (1067,1113,907,1113) | 25–40 m; **Karaoke Box tower landmark** at (1085,1050), 8-storey vertical-signboard stack — on the approach to air-train crossing #1 |
| S-curve West 1 | (1215,1300,667,893) | 25–45 m; **driver-facing kanban wall** on the x=1300 east face (reads through the S-curves) |
| S-curve West 2 | (1215,1300,907,1113) | 25–45 m; same kanban-wall treatment |
| South Gate | (1067,1300,67,193) | 25–35 m transitional edge (steps down toward South Ridge); taxi stand fronting Dori Ave at (1100,207) |

East column (x ≥ 1420), west faces driver; clear of the SE air-train corner arc
(center (1440,560), r=80, ±7 m corridor — blocks keep the corridor clear):
| Block | Rect (x0,x1,z0,z1) | Content |
|---|---|---|
| Spire Block | (1420,1513,560,1040) | **Tower-in-plaza cluster:** 35–70 m towers set back with plaza between them (not filled to lot lines); **Midtown Spire landmark** at (1465,800), 90 m slender tower — vista terminus for Neon Ave northward, silhouettes over the fabric from both air-train crossings; **construction crane** at (1465,700) with lit aviation beacon (vista-terminus accent, tower crane on an unfinished block); rooftop penthouse/mechanical units on every roof; podium retail frontage on the west face |
| Pachinko North | (1420,1513,1040,1113) | **Pachinko parlor front** (パチンコ, dense multi-color tubes) facing west toward crossing #1 at (1316.9,1120) |
| East Strip South | (1420,1513,487,520) | Rail-adjacent service block; only corridor-compliant infill (12–20 m, rooftop-dressed) |

Landmark sightline logic (planning takeaway #6): karaoke tower and pachinko sit on
the approach/exit of crossing #1 (s≈2535); the Spire is visible from both crossings
and through the S-curve; the kanban walls on S-curve West 1/2 are placed exactly
where the driver's eyes go mid-corner. Nothing blocks the racing corridor — all
landmarks are ≥44 m from the centerline, well outside B3.
