# Tokyo Drift — METHODOLOGY.md (sightline-driven build doctrine, v1)

The backbone of how the Godot city gets built. Every builder rule in
CITY_LAYOUT.md, every camera note in TRACK_ANGLES.md, and every district
section in SCENE_DESIGN.md hangs off this page.

## 1. Start cheap: 2D planning first

No 3D massing until the 2D plan reads as a city. The circuit route, district
rects, arterial grid, shoreline, bridge, tunnel, expressway, and air-train all
exist as 2D line-and-rect plans first (see `city-plan-map.png`). A 2D plan that
reads wrong is cheap to fix; a city built in 3D on top of it is not. No block
goes to massing before its rect is on the map and survives the 2D read.

## 2. Sightline-driven build: the chase camera is the survey instrument

The build walk order is the lap itself, section by section (districts §2 in
CITY_LAYOUT.md; the 22 waypoint rows; the framing notes in TRACK_ANGLES.md).
For each section, classify every trackside area by what the chase camera
(~8 m behind the car, ~3.5 m up, looking 30–50 m ahead) actually sees:

- **(a) BLOCKED BY FACADES** — near-field zones occluded by 1–2 layers of
  street-facing buildings. These get **cheap facade shells only**: front face
  + side faces, no interiors, no backsides. Nobody sees in, nobody sees behind.
- **(b) INTENTIONAL OPEN AREAS** — plazas, the bay waterfront, parks, wide
  intersections, portal corridors, tower-in-plaza gaps. These are deliberately
  open, so they must be **filled with designed content**: landmarks, props,
  ground treatment, lighting. Open ≠ empty.
- **(c) DISTANT BACKDROP** — far-field skyline and beyond-facade zones. These
  get **2D backdrops / silhouette layers ONLY — never geometry**. A box on the
  horizon is a drawn card, not a mesh.

The per-section (a)/(b)/(c) classification lives in SCENE_DESIGN.md ("Sightline
classification" table); the builder rules keyed to it live in CITY_LAYOUT.md
§13; the camera notes that reference it live in TRACK_ANGLES.md.

## 3. Build priority = visibility

Only what the camera sees gets real geometry. Everything else is facade shells
or 2D backdrops. Explicit goal: **a long, believable circuit WITHOUT building
a full open world.** The city is a corridor of well-built set pieces stitched
to 2D horizons — 5.2 km of track, not 5.2 km² of city.

### Per-class build rules (binding)

| Class | What gets built | What is forbidden |
|---|---|---|
| (a) Facade shells | First 1–2 building layers trackside: front + side faces with mounted signage, podium retail band, street furniture; rooftop dressing (penthouse/parapet units) only where the silhouette reads from track elevation | Interiors. Backsides (back walls may be omitted or flat). Geometry deeper than 2 layers or \|lat\| > 60 m — that is class (c) |
| (b) Open areas | Real, designed, walkable-depth content: landmarks (real geometry), props, planters, railings, ground planes, registered light sources; sightline corridors kept clear | Empty ground, flat color planes, filler shells pretending to be content |
| (c) Backdrop | 2D silhouette strips / billboard planes: port cranes, industrial skyline, far-shore massing; dark-blue emissive lift (never pitch black); planes at 300–900 m from the nearest track point | ANY 3D geometry. Parallax cheats that break on corners |

### Cross-class rules

- **Landmarks are class (b) content, never shells.** Anything the driver's eye is
  *aimed at* (portal frames, gantry, spire, chimney cluster, cranes, torii) is
  real geometry even when it sits inside an (a) zone.
- **Facade-mounted signage is the facade.** The Tokyo read lives on the shells
  (see PLANNING_LANGUAGE.md takeaway #7): kanban bolted to walls, back-boxes
  sunk in — shells without their signage layer are unfinished shells.
- **Fidelity tiers are orthogonal to classes.** A Tier 2 district at class (a)
  is still a *cheap shell* — just a designed one. Tier 1 downtown's class (a)
  shells carry dense kanban; that is facade detail, not a change of class.
- **The tube interior is none of the three.** Inside the tunnel there is no
  scenery within ±12 m lateral of the centerline (TRACK_ANGLES.md §4) — the
  (a)/(b)/(c) split resumes at the retaining walls.
- **Water is class (b) where the camera crosses it** (bridge leg, waterfronts):
  real surface, registered light streaks only — but far shores seen from the
  bridge are class (c).

### The "no full open world" goal

Measure success by camera coverage, not by city completeness: every meter of
track must have a believable frame on all sides the camera can turn to, and
NOTHING off-camera is built. If a district reads great on the 2D map but its
classification table has unmarked trackside areas, the classification is
unfinished — walk the lap again.
