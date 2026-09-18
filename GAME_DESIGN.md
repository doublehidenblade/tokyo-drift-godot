# Tokyo Drift Godot — Game Design

**Decision (2026-09-18, Craig):** Godot 4 + store-bought asset packs + Android APK
export to his Samsung. The web Three.js build keeps iterating in parallel until
the Godot version is playable. Nothing here is invented: every system below
traces to Craig's asks from the past days (see `docs/` in the web repo and
`~/workspace/tokyo-drift-3d/CITY_PLAN.md`, which this design adopts as the city
source of truth).

Local Godot binary: `./godot` (4.7.2.stable). Asset shortlist: `ASSET_SHORTLIST.md`.

## 1. The game

Neon Tokyo night **arcade drift racer**, stylized (Leartes / Synty look — not
realistic). Closed circuit through a real planned city. One-thumb-plus-nitro
controls on a phone. 3-lap races against the clock and traffic.

**Fantasy:** rain-slick neon streets, a suspension bridge over a bay, a lit
tunnel through a ridge, an elevated expressway and an air-train crossing
overhead, Japanese signage everywhere, nitro fire in the rear-view.

## 2. Tech

- **Engine:** Godot 4.7 (GLES3 / gl_compatibility renderer — the mobile-safe
  path; no postprocessing on device).
- **Language:** GDScript throughout. Events via scene-tree composition +
  **signals** (the node-connector workflow: `Area3D.body_entered`,
  custom signals on autoloads, signal buses per system).
- **Physics:** Godot Physics (built-in). Arcade car model — Craig's rule:
  this is arcade driving with real collision contacts, not tire/suspension sim.
- **Distribution:** Android APK export (landscape, 1280×720 base). Debug APKs
  for iteration; release APK only with Craig's explicit approval. **Never
  install or push anything to his Samsung without him saying so.**
- **Input:** touch (left/right screen halves steer, one nitro button) +
  keyboard fallback (arrows/AD, Space nitro) for desktop testing.

## 3. World: the city comes first (from CITY_PLAN.md)

Same layout the web build is moving to — the Godot build inherits the plan,
not the implementation:

- **Districts:** Start Plaza / Mid-rise commercial → Harbor West (warehouses,
  containers) → The Climb → **Bay Strait + suspension bridge** → Waterfront
  East → **DOWNTOWN neon core** (tallest towers, densest signage) →
  South Ridge + tunnel → Industrial Edge.
- **The Bay:** real water body; bridge spans its mouth; port skyline + cranes
  on the far shore.
- **Verticality:** elevated expressway crossing over the track; an **air-train
  loop** threading between downtown towers and crossing the circuit twice;
  the bridge itself. Verticality from overlapping infrastructure, not from
  stacking decor.
- **The circuit** is routed *through* the planned city (~5 km loop, same
  beat map as the web build: start/finish plaza, harbor straight, bridge leg,
  downtown gauntlet, tunnel leg, industrial run-in).

## 4. Gameplay systems

- **Driving — heading-based (Craig's rule, 2026-09-18).** The car goes where
  its nose points. No steering input = straight line. Steering turns the car;
  road curvature never turns the car. Containment: guard rails / barriers /
  respawn so free driving can't leave the world.
- **3-lap races**, auto-acceleration, arcade drift (handbrake-style slide on
  hard steering at speed — tune by feel, verify with the harness).
- **Nitro:** bottles placed on the circuit; pickup refills the meter; one-tap
  full burn (no passive regen — carried over from the web build).
- **Traffic:** two-way, both directions, on the whole circuit. Cars stream in
  at distance (no popping — Craig's ghost-car complaint) and are visibly
  rendered before they can collide. Collisions bump cars apart by relative
  contact direction and closing speed.
- **5 hearts.** Damage from hard wall/traffic hits; lose all → race over.
  (Standing rule: keep 5 unless Craig changes it.)
- **Guard rails:** continuous rails both sides of the circuit with colliders;
  bridge railing unified into the same system.

## 5. Controls

- Hold **left / right screen half** to steer (hit-tested from the touch
  position — the web build's proven scheme).
- One circular **NITRO** button, bottom-right, edge-triggered.
- Steering is **screen-relative**: verify in screen space via camera
  projection (the skill pack
  `~/workspace/game-dev/skills/screen-space-steering-verification/` —
  the reversal happened twice on the web build because checks measured the
  world, not the screen; the gate is negative-controlled).

## 6. UI

- **Retro menu** (carried over from the web build): title, START, and the
  **World Inspector** button.
- **World Inspector** (Craig's ask): in-menu mode with two views —
  (a) orbit/zoom viewer for **every 3D model asset individually** (each
  distinct asset gets a registry entry, so fidelity/variety can be iterated
  per-model), (b) **2D city-plan view** (top-down district/road/bridge/
  tunnel/track map) so world design iterates separately from models.
- HUD: speed, lap, race time, nitro meter, hearts. Pause button.

## 7. Art direction

- Stylized low-poly neon Tokyo at night. Teal/cyan + magenta/pink city-pop
  palette with sodium-orange industrial accents (the web build's palette,
  which Craig liked).
- **Signs physically mounted on buildings/supports** — vertical signboards on
  storefronts, billboards on walls, screens embedded in facades. No floating
  signs, no timer-repeating signs. (Standing rule from the web build.)
- **Asset honesty:** store-bought assets are real assets — credit the pack
  and artist in `assets/ATTRIBUTION.md`. Never present procedural or
  generated art as designer-drawn. Store packs are the *opposite* of the
  procedural-art problem: they're genuinely authored.
- Night lighting: emissive materials for neon + a **small budget of real
  lights** (a handful of OmniLights for tunnel/bridge; the rest is emissive
  + baked-looking vertex color). No real-time shadows on mobile except maybe
  the player car blob shadow. Reflections only where a visible source exists
  (Craig's unmatched-reflection complaint on the web build).
- Road markings: solid center line splitting traffic directions + varied lane
  dashes (his road-marking complaint).

## 8. Scene / code structure

```
scenes/
  main.tscn            # boot → menu / race / inspector switching
  menu/                # retro menu + world inspector
  race/                # circuit, city districts, traffic, pickups
  player/              # player car scene (swap mesh per asset pack)
  traffic/             # traffic car variants
scripts/
  autoload/            # game state, signal bus, settings
  race/                # lap logic, nitro, traffic spawner, hearts
  player/              # arcade car controller (heading-based)
  ui/                  # menu, HUD, inspector
  tools/               # city builder helpers, asset registry
assets/
  packs/               # store packs, one folder per pack, with license files
  prototypes/          # free/CC0 packs for the vertical slice
  ATTRIBUTION.md       # every asset's source, author, license
```

- **Asset registry:** every distinct model gets an id
  (`downtown_tower_a`, `player_racecar`, `streetlight_teal`, …) used by the
  World Inspector and the harness.
- **City built from data:** district layout lives in a resource/JSON
  (ported from CITY_PLAN.md), not hand-placed in the editor — reproducible,
  auditable (the web build's building-in-the-road bug becomes a build-time
  audit: no building footprint may intersect the circuit + margin).

## 9. Performance budget (Samsung, GLES3)

- Low-poly packs only; target < 150k visible tris per frame.
- One shared material palette where possible; merged static geometry per
  district (MultiMeshInstance3D for repeats: streetlights, signs, trees).
- Lights: ambient + directional (moon) + ≤ 8 real OmniLights (tunnel,
  bridge). Everything else emissive.
- No postprocessing on device. 2× MSAA.
- Traffic: ≤ 20 active cars, simple LOD (hide at distance, never pop
  within collision range).

## 10. Verification (the harness, Godot-side)

Per `~/workspace/game-dev/harness/`: event logging (lap/nitro/collision/
heart events on the signal bus), crash-trace collection, scripted
screenshots, video capture of drive-throughs, e2e full races, scenario
tests (steering screen-relative, tunnel never black — full-circuit luma
sweep, bridge, nitro, traffic no-ghost), one `run.sh` gate. Godot headless
(`--headless`) runs the suite in CI fashion. **His phone verdict stays the
only valid mobile verdict** — the gate is necessary, never sufficient.

## 11. Milestones

1. **Vertical slice:** one downtown street + start plaza, store-bought player
   car + 3 traffic cars, heading-based driving, touch controls, 1 lap,
   nitro bottle, retro menu. Debug APK.
2. **City pass:** all districts per CITY_PLAN.md, bay + bridge, tunnel,
   expressway + air-train, guard rails, full 3-lap race.
3. **World Inspector** + asset registry; street-level dressing pass
   (facade-mounted signs, shopfronts, wires, pedestrians).
4. **Polish gate:** harness green + Craig's phone verdict → release APK.

## 12. Open questions for Craig

- Which packs to buy (see ASSET_SHORTLIST.md — approval needed per pack).
- Distribution: APK install on his Samsung per release (needs his explicit
  go-ahead each time), vs. also keeping a web export.
- Drift feel target: grippy arcade vs. slidey — tune after the slice.
