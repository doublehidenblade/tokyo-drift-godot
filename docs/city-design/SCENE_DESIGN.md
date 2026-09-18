# Tokyo Drift (Godot) — SCENE DESIGN

City scene design for the neon-Tokyo arcade racer. Districts follow the
8-block lap layout in `~/workspace/tokyo-drift-3d/CITY_PLAN.md` (source of
truth for track s-ranges, bay bounds, bridge/tunnel specs). Track geometry
itself is unchanged — this doc covers look, mood, landmarks, and props.

**Palette (global):** teal/cyan + magenta/pink neon on night-blue base;
sodium-orange reserved for industrial districts. Warm-white shopfront light
punctuates commercial districts.

**Standing rules (apply to every district):**
- Every sign is physically mounted on a building (kanban bolted to walls,
  signboards with visible back-boxes). No floating signs, no sign that
  repeats on a timer or drifts independently of its building.
- Reflections/wet streaks appear ONLY under a registered light source
  (position + color recorded), within 15 m of it, matching color family.
  No free-floating glow blobs, no portal flares.
- Buildings keep clear of the road — footprint corners never inside
  roadHalf + 2.5 m (hard build-time audit, violations = 0).
- No pitch black: silhouettes get emissive lift (dark blue, never black).

---

## Fidelity tiers (Craig's direction, 2026-09-18)

No time limit, but proof-of-concept and fast iteration rule. Two tiers:

**Tier 1 — Showcase: DOWNTOWN Neon Core (district 6).** The highest fidelity the
$0 path allows: full block structure (see CITY_LAYOUT.md §14), vertical-layered
towers (commercial band / shaft / rooftop dressing on every block), dense
physically-mounted kanban (vertical signboards + horizontal boards + back-boxes),
poles with sagging wires, vending clusters, noren, AC/pipes on facades, the
air-train viaduct with running train, and bespoke landmarks (pachinko parlor,
karaoke box tower, Midtown Spire). This is the district that sells the game; it
gets the detail budget.

**Tier 2 — Intentional low-fidelity: all other 7 districts.** Lower geometry
budget, but never bare procedurals: layout, massing, road hierarchy, lighting
mood, and landmark placement are deliberate and documented (the district sections
below). What "intentional" means per district at Tier 2, and what is deferred:

| District | Intentional at Tier 2 (kept) | Deferred to later |
|---|---|---|
| 1 Start Plaza | Block layout, gantry + pit landmark, warm-white/teal mood, shopfront band on every block | Per-shop interior variety, dense awning/noren variation |
| 2 Harbor West | Yard/block layout, crane-gantry landmark, container-stack massing, cool-blue mood | Per-container stencil variety, fine yard clutter |
| 3 The Climb | Terraced massing stepping with the gradient, sentō landmark, amber residential mood, alley stairs | Balcony/laundry per-unit detail, rooftop clutter |
| 4 Bay Strait + bridge | Full structural spec (towers, cables, truss — geometry IS the landmark), ice-blue mood | Far-shore skyline detail beyond silhouettes |
| 5 Waterfront East | Promenade/pier layout, torii landmark + registered reflection, teal/warm mood | Café-terrace per-table dressing, boat variety |
| 7 South Ridge + tunnel | Portal headwalls + mounted boards, retaining walls, ridge massing per §5, compressed dark mood (never black) | Ridge vegetation detail, tunnel wall texture variety |
| 8 Industrial Edge | Chimney-cluster landmark, shed/sawtooth massing, sodium-orange mood, yard layout | Per-shed window/strip variation, forklift-level props |

Rule: a Tier 2 district may look simple, but it must look *designed* — deliberate
silhouettes, deliberate light, one clear landmark. "Simple" is a budget;
"arbitrary" is a bug.

**Tier 2: same planning language, applied at massing level.** The reference
language is not fidelity-dependent — Tier 2 districts get the same
*composition* with cheaper *execution*:
- **Block-unit thinking everywhere.** Every district places blocks first, from the
  arterial table; regular grid where it fits (Start Plaza, Industrial Edge),
  slope-terraced or yard-broken where the terrain demands it (The Climb,
  Harbor West). Blocks are still the unit — buildings never float free of one.
- **Peak-and-fabric per district.** Each district has its own deliberate height
  band and its own peak: sentō chimney on The Climb, crane gantry in Harbor
  West, chimney cluster in Industrial Edge, torii in Waterfront East. Even at
  low fidelity the skyline varies *by rule* (rooftop penthouses/mechanical units
  on every block — cheap boxes, huge silhouette payoff).
- **Street hierarchy everywhere.** Arterials get zebra crossings + signal poles
  at junctions (low-poly, few polys each); collector roads frame blocks; yokocho
  alleys texture the Japanese districts. No district is "no street design."
- **Green strips / parks at district edges.** Each district edge gets at least
  one planted pocket: matsu planters in Waterfront East, planter beds at the
  Start Plaza corners, tree-lined sidewalk bands in the residential fabric —
  the Midtown pack's edge-greening rule, even if it's just grass boxes and
  low-poly trees at Tier 2.
- **Vertical accents.** One per district minimum: Harbor West's container crane,
  Industrial Edge's chimney cluster, the bridge towers, tunnel portal headwalls,
  downtown's construction crane. Tall things silhouetted against the sky sell
  scale for free.

---

---

## Sightline classification (a)/(b)/(c) — Craig's methodology

Every district's circuit frontage is walked here and classified per
METHODOLOGY.md: **(a)** BLOCKED BY FACADES → cheap shells only;
**(b)** INTENTIONAL OPEN AREAS → designed content; **(c)** DISTANT
BACKDROP → 2D silhouettes only. Sides are world-cardinal; laterals are
track-space meters from the centerline.

| District / s-range | Class | Zone (side + lateral range) | Treatment |
|---|---|---|---|
| **1 Start Plaza** 4941→0→470 | (a) | West + east flanks, \|lat\| 18–60 m | 8–20 m mid-rise commercial facade shells (both sides frame the straight) |
| | (b) | Gantry apron, s ± 40 m around the line | Start gantry (real), pit lane on +lat 18–32, planter corners, plaza paving |
| | (c) | North beyond z≈470, south beyond z≈-260 | 2D skyline cards (Harbor West roofline; Industrial Edge shedline) |
| **2 Harbor West** 470–1235 | (a) | West side (x<0), \|lat\| 18–60 m | Warehouse facade shells, shutter doors + stencil kanji |
| | (a) | East side, \|lat\| 18–60 m | First container-stack layer (low, 6–12 m) |
| | (b) | Bay-view corridor, x 380–500 (east of Container Way) | Deliberately open yard apron: dock bollards, quay edge, mast lights — lets the chase cam catch water between stacks |
| | (b) | Crane-gantry crossing zone | Container-crane landmark (real geometry) |
| | (c) | Far north shore, z 2260–2400, over the water | Port cranes + industrial skyline as 2D silhouettes |
| **3 The Climb** 1235–1502 | (a) | West side terraces, \|lat\| 18–60 m | Stepped apartment facade shells climbing with the grade |
| | (b) | East side, bay-facing, incl. NE-corner shoreline | Terraced retaining-wall gardens, shore strip, sentō bathhouse + chimney landmark |
| | (c) | Far north shore (z≈2260) from the east side | Port-crane + far-shore silhouettes over the water |
| **4 Bay Strait + bridge** 1502–2285 | (b) | **Bridge leg, s 1566–2284: BOTH sides open over water** | Real water; tower portal frames (real landmarks); deck edge strips, truss framing the lower shot |
| | (a) | Shore approach strips: s 1502–1566 (west), s 2284–2285 (east) | First building layer only — shells |
| | (c) | **Far north shore (z≈2260) + far west shore terraces** | Crane + industrial skyline 2D cards; no geometry past the shores |
| **5 Waterfront East** 2285–2573 | (b) | West side, bay side: promenade + piers, x 1060–1180 | Torii landmark (real), pier decks, railings, benches, matsu planters, tōrō lanterns |
| | (a) | East side, \|lat\| 18–60 m | Low commercial facade shells |
| | (c) | Far west shore (The Climb terraces) across the bay; south bay mouth off-map | 2D terrace silhouettes over the water |
| **6 DOWNTOWN Neon Core** 2573–3573 | (a) | **Both sides near-field, \|lat\| 18–60 m** | Tower/podium facade shells — Tier 1 kanban density ON the shells (facade detail ≠ class change) |
| | (b) | Spire Block plaza gaps (1465,800); karaoke-tower approach s≈2500–2535; pachinko front at crossing #1; Sakura Dori × Neon Ave intersections; crane block | Spire, karaoke box, pachinko, crane — all landmarks are real geometry; zebra/signal junctions designed |
| | (c) | **Everything beyond \|lat\| 60 m (second layer+)** | Tower silhouettes as 2D cards behind the shells — the canyon reads deep for the cost of cardboard |
| **7 South Ridge + tunnel** 3533–4318 | (a) | None on the surface legs | No buildings on the ridge — nothing to shell |
| | (b) | Entry approach s 3530–3570; exit corridor s 4278–4318 | Headwalls (real), 40 m retaining walls, ridge hills at \|lat\| 30–90 m (terrain massing, real, dark-blue emissive), chimney-cluster vista from the exit leg |
| | (c) | Beyond the ridge | 2D skyline cards: downtown glow from the entry approach, industrial silhouette from the exit leg |
| | — | Tube interior | Not classified: NO scenery within ±12 m lateral of the centerline |
| **8 Industrial Edge** 4318–4941 | (a) | Both sides, \|lat\| 18–60 m | Warehouse/shed facade shells, sodium-lit |
| | (b) | Chimney-cluster zone on the tunnel-exit sightline; container-yard gaps; Furnace Rd corridor | Chimney cluster (real landmark), designed yard aprons |
| | (c) | North ~1.5 km; far south | 2D cards: downtown glow skyline, far industrial silhouette |

Rule of thumb for builders: if the class in this table disagrees with what a
district section says, the table wins and the section gets fixed.

---

## 1. Start Plaza / Mid-rise Commercial (s 4941→5227→0→470)

**Visual identity.** The home straight feels like a suburban Tokyo
commercial strip at race time: 8–20 m mixed-use blocks with lit ground-floor
shopfronts, striped noren and awnings, and a proper start gantry over the
line. Bright and legible — this is the "broadcast camera" zone, so nothing
obscures the racing line.

**Signature landmark.** The start gantry: a trussed arch spanning the
track with a mounted "START / スタート" board, checkered-pattern side
panels, and start-light tree recessed into the beam (not a glow sprite).

**Lighting mood.** Warm-white shopfront spill + teal streetlight heads
every 30 m. Magenta accents reserved for the gantry and pit-adjacent
facades so the line reads instantly at 200 m out.

**Prop set.**
1. Start gantry (truss + mounted board + recessed light tree)
2. Directional gantries (road signs bolted to overhead beams)
3. Lit shopfronts with striped awnings / noren curtains
4. Vending machines (lit, against walls — never mid-sidewalk)
5. Street trees in planters
6. Bollards at plaza corners
7. Parked cars with windshields, mirrors, grilles, headlights
8. Power poles with sagging catenary wires

**Reads as Tokyo because:** konbini with glowing "24h" band, izakaya
chochin lantern strings under eaves, noren curtains with shop names in
kana, jidōhanbaiki (vending machines) clustered at building corners,
koban (police box) at the plaza edge.

**Mistakes to avoid:** dead empty street — this district sells the race,
so every shopfront must be lit and staffed with props, not a dark shutter
row; buildings never in the road (B3 audit); glow flares instead of
recessed gantry lights (B5).

---

## 2. Harbor West (s 470–1235)

**Visual identity.** Low-slung port warehouse blocks (6–12 m) with
corrugated procedural facades, container stacks in primary colors, and
open yard space between buildings. Runs along the bay's west shore —
the air here is cooler and emptier, a deliberate breather after the
plaza.

**Signature landmark.** A container-crane gantry straddling the track's
west shore approach: four legs, crossbeam with a hanging spreader, and
an orange beacon on top — the industrial gate you pass under before the
climb.

**Lighting mood.** Cool moonlit blue with teal work-lights; single sodium
floodlight on the crane gantry. Reflections here live on the bay water
only — streaks generated strictly under the floodlight and shore lamps.

**Prop set.**
1. Container stacks (3–4 high, varied colors, end doors facing track)
2. Warehouses with roll-up shutter doors + small wall lamps
3. Pallets, crates, and barrel clusters
4. Dock bollards and tire fenders along the quay edge
5. Seagull-ish bird silhouettes? No — keep procedural: mast lights on
   moored low-poly boats
6. Chain-link fence runs between yards
7. Power-line poles running parallel to the track
8. Warning stripes / painted ground markings at yard entries

**Reads as Tokyo because:** Tokyo Bay warehouse districts look like this
— the Odaiba/Ariake logistics sprawl. Japanese port signage (港運,
倉庫 in stencil kanji on container sides), small shore shrine (hokora)
with a torii at the yard corner, noren-less shuttered shotengai stub.

**Mistakes to avoid:** flat unlit warehouse boxes (every box gets wall
lamps, shutters, or stencil detail); random water/road streaks with no
light source (B6); the yard feeling like a parking lot — keep stacking
irregular and let fences/props break the grid.

---

## 3. The Climb (s 1235–1502)

**Visual identity.** Mixed mid-rise (10–25 m) stepped up a hillside: blocks
terraced at different heights with retaining walls, narrow side streets
branching off, a kissaten-and-apartment neighborhood feel. The track
climbs; the buildings should read as climbing with it.

**Signature landmark.** A hillside sentō (public bath): a low bathhouse
with its signature tall chimney (fuji-style), noren at the door, and
steam vents emitting soft particle wisps lit cyan from the bathhouse
lamps.

**Lighting mood.** Warm amber windows (the most residential district)
layered over teal streetlights; steam catches the light. Staircase
lamps down side alleys give depth without clutter.

**Prop set.**
1. Terraced retaining walls with planted greenery on top
2. Sentō bathhouse + tall chimney + steam wisps
3. Hillside staircase with railing and step lamps
4. Apartment blocks with lit/unlit window variation + AC unit boxes
5. Small shrine nook (hokora) at a stair landing
6. Bicycles parked against walls
7. Narrow side-street gutters and curb ramps
8. Laundry poles (monohoshizao) on a couple of balconies

**Reads as Tokyo because:** sentō chimneys, hokora shrines, monohoshizao
laundry poles, kissaten signage, bicycle density, the terraced hillside
urbanism of Yanesen/Nakameguro-type slopes.

**Mistakes to avoid:** hills as pitch-black walls behind buildings
(B1 — hills ≥150 m from track, emissive lift to dark blue); buildings
crowding the road on the climb (B3 audit); over-uniform road markings
here — the climb's texture gets the varied dash set (B7).

---

## 4. Bay Strait + Suspension Bridge (s 1502–2285)

**Visual identity.** The lap's set piece: a suspension bridge over open
water (deck y 13–20, tower-to-tower span s 1600–2200). Portal-frame towers
(2 columns + 2 crossbeams + X-bracing, blue-lit), main cables running
EXACTLY over the column tops with saddle blocks, Warren stiffening truss
under both deck edges, suspenders cable→deck, deck girder box under the
road so nothing floats. Far north shore (z ≈ 2260) carries the industrial
port skyline.

**Signature landmark.** The two portal towers themselves — the blue-lit
X-braced frames you thread between at speed. Approached from the climb,
they should silhouette against the bay for a full 300 m.

**Lighting mood.** Deep night-blue water; tower uplights in ice-blue;
deck edge light strips in teal; far-shore port cranes with orange
beacons pulsing. Water streaks ONLY under the deck strips and shore
beacons.

**Prop set.**
1. Portal towers (columns + crossbeams + X-bracing + saddle blocks)
2. Main cables + suspender rods + Warren truss
3. Deck girder box + unified railing (continuous with guard-rail system)
4. Four procedural port cranes on the far north shore, orange beacons
5. Industrial silhouette skyline behind the cranes
6. Navigation lights on the water (registered sources)
7. Moored barges near the west shore
8. Quay wall along the far shore

**Reads as Tokyo because:** the span quotes Rainbow Bridge — the
blue-lit towers, the double-deck read, Odaiba-side industrial skyline
with crane beacons echoing Tokyo Bay at night.

**Mistakes to avoid:** disconnected bridge parts (cables must sit ON the
column tops; truss, rails, towers read as one structure — B2); the road
floating above the deck (girder box under the ribbon); meaningless glow
flares on the towers (recessed strip lights only); water streaks with no
source (B6).

---

## 5. Waterfront East (s 2285–2573)

**Visual identity.** The calm after the bridge: a promenade along the
bay's east shore with low commercial buildings, piers jutting into the
water, and open sky. Less neon, more breeze — planting, railings, and
lampposts rather than signage.

**Signature landmark.** A small pier with a torii gate at its landward
end — a waterfront jinja gate lit warm from below, mirrored (via a
registered light source) in the bay. The photo spot of the lap.

**Lighting mood.** Teal lampposts along the promenade; warm light pools
under the torii; distant magenta bleed from downtown ahead on the horizon
— the city you are about to enter glows before you do.

**Prop set.**
1. Torii gate at the pier (warm underlights, registered source)
2. Wooden pier with mooring posts and ropes
3. Promenade railing + benches facing the bay
4. Lampposts (teal heads) along the walkway
5. Planter beds with pruned pines (matsu)
6. Low commercial blocks with café terraces
7. Moored small boats with mast lights
8. Stone lantern (tōrō) at the promenade steps

**Reads as Tokyo because:** waterfront torii (Odaiba's palette without
the copy), tōrō stone lanterns, matsu plantings, pier mooring culture of
Tokyo Bay, kissaten terraces facing the water.

**Mistakes to avoid:** dead empty promenade — benches, planters, boats
and lanterns must fill it; floating glow blobs at the torii (mount the
underlights physically); streaks on the water not tied to the torii or
lamppost sources (B6).

---

## 6. DOWNTOWN Neon Core (s 2573–3573)

**Visual identity.** The densest district, organized as a **tower-in-plaza
highrise cluster ringed by 5–10 storey mid-rise blocks** (the Midtown pack's
concrete pattern, §14 for the block map): 35–70 m towers sit back inside their
blocks with hardscaped plaza at their feet — they do NOT fill to the lot
lines — while 15–35 m mid-rise fabric builds to the block edges around them,
carrying the signage density at the driver's eye level. Every tower rises out
of a **1–2 storey commercial podium / retail frontage** — continuous lit
shopfronts, kanban, noren — never a bare shaft dropping to the sidewalk.
Night-neon translation of the kitbash reference's golden-hour street canyons:
keep its *density of lit surfaces* (every billboard lit, every shopfront
glowing) and its *long-shadow canyon read*, but with cyan/magenta facade
tubes and warm-white shopfront spill instead of warm sun. No dead dark facade
faces the racing line. The air-train loop threads between towers (rail y = 13,
crossing the track twice at s ≈ 2540 and s ≈ 3300 with 7 m+ clearance);
buildings skip a 14 m corridor around it.

**Signature landmark.** The air-train crossing: a 4-car train looping at
22 m/s on a rounded-rect viaduct between the towers, passing OVER the
track twice. Pair it with the densest signboard cluster — a pachinko
parlor front (パチンコ, crisp multi-color tubes) facing the s ≈ 2540
crossing. Supporting landmarks per the block plan (CITY_LAYOUT.md §14):
the Karaoke Box tower (vertical-signboard stack at the crossing approach),
the 90 m Midtown Spire (vista terminus, silhouettes over the fabric), and a
**construction crane** (tower crane with lit aviation beacon on top, sited at
a vista terminus on the S-curve east face per PLANNING_LANGUAGE takeaway #9) —
the unfinished block reads as a growing city.

**Street treatment.** Arterial junctions get **zebra crossings** on the
approaches and **signalized intersections**: pole-mounted signal heads plus
Japanese-style gantry signals on Neon Ave. Street trees line the arterial
edges; overhead utility poles with sagging catenary wires run the collector
streets. **Green strips at the district edge** — planted seating pockets where
downtown meets the fabric blocks south of Dori Ave.

**Lighting mood.** Maximum saturation: magenta/pink and cyan washing the
street from facade-mounted tubes; shopfront warm-white at ground level.
This is the brightest district on the lap by a clear margin.

**Prop set.**
1. Vertical signboards + horizontal kanban (back-box mounted, varied
   kanji: 酒, 麺, 歌, 宿, 喫茶) — densest on the podium bands
2. Air-train viaduct + pylons + 4-car train (infrastructure spine,
   PLANNING_LANGUAGE takeaway #8)
3. Pachinko parlor front with dense tube signage
4. Karaoke (カラオケ) and izakaya (居酒屋) facades with chochin strings
5. Konbini corner with lit "24h" band
6. Taxi stand with a row of parked taxis (roof lights on)
7. Pedestrian overpass with walkers
8. Directional gantries + dense streetlight rhythm
9. Zebra crossings + signal poles / gantry signals at arterial junctions
10. Street trees in planters along arterial edges
11. Construction crane with lit beacon (vista-terminus accent)
12. Rooftop penthouses + mechanical units on every tower (penthouse boxes,
    AC plants, tanks, antenna masts — each roof a different combination;
    the skyline-variation rule)

**Reads as Tokyo because:** kanban typography (vertical signboards are
the single strongest Tokyo signal), pachinko parlors, karaoke boxes,
izakaya chochin, konbini, taxi stands with black sedans, the Yurikamome
-style elevated train threading towers like Odaiba/Shiodome.

**Mistakes to avoid:** the big ones all live here — fake floating neon
signs (standing rule: every sign bolted to a wall, never repeating on a
timer); buildings in the road (B3 hard audit; also keep the 14 m
air-train corridor clear); over-uniform road markings (B7 varied dash
lengths, this district reads them most); traffic cars popping in without
the 0.8 s fade (B4); glow meaning nothing (every streak from a
registered source, B6).

---

## 7. South Ridge + Tunnel (s 3533–4318)

**Visual identity.** A hill ridge flanking the tube; the track dives into
concrete portal headwalls (side pylons + top beam, procedural concrete
texture) with a mounted "トンネル TUNNEL" board bolted to the beam.
Recessed emissive edge strips mark the portals — the old glow-flare
blobs are gone for good. Ridge hill masses flank at |lat| 30–90 m.

**Signature landmark.** The tunnel portals themselves: headwall +
mounted TUNNEL board + recessed strips + 40 m of retaining walls out from
each portal. The exit portal at s ≈ 4278 is the lap's exhale — daylight
(or downtown glow) bursting back.

**Lighting mood.** Dark and compressed inside: sealed tube, strip lights
along the walls, sconces, 8 point lights, tunnel-only ambient — NEVER
black. Outside, near-dark ridge with cyan edge strips; the exit blows
out into industrial sodium-orange.

**Prop set.**
1. Concrete portal headwalls (pylons + beam + procedural concrete)
2. Mounted "トンネル TUNNEL" boards (bolted, not floating)
3. Recessed emissive edge strips at portals
4. 40 m retaining walls at each portal mouth
5. Ridge hill masses (|lat| 30–90 m, emissive lift, no camera-blocking
   over-tube geometry)
6. Interior wall strips + sconces + point lights
7. Tunnel wall reflectors / chevron boards (mounted)
8. Drainage grates along the tube walls

**Reads as Tokyo because:** Japanese expressway tunnels (Shuto/Metropolitan
Expressway portals) with their mounted TUNNEL kanji boards and concrete
headwalls; hillside retaining walls of Tokyo's western suburbs.

**Mistakes to avoid:** glow-flare blobs at the portal (B5 — deleted, use
recessed strips); pitch-black interior (tunnel-only ambient kept, never
black); hills too close and too dark (B1 — ≥150 m, emissive lift);
anything over the tube that blocks the chase camera (M4 removed those —
never re-add).

---

## 8. Industrial Edge (s 4318–4941)

**Visual identity.** The raw end of the lap: warehouses, factory sheds,
tall chimneys with aircraft-warning beacons, container yards, and
sodium-orange as the dominant accent. Wider, emptier, louder-looking —
the cool-down before the plaza's brightness returns.

**Signature landmark.** A chimney cluster: three tall stacks with red
beacon lights pulsing in sequence, guy-wire stays, and a low factory
block with lit windows at the base. Visible from the tunnel exit —
the "you're almost home" marker.

**Lighting mood.** Sodium-orange floods over asphalt; teal streetlights
only along the track itself; red chimney beacons pulsing. Fewer neon
sources here — this district is about big shapes and orange pools of
light.

**Prop set.**
1. Chimney cluster (3 stacks, red beacons, guy wires)
2. Factory sheds with sawtooth roofs + lit windows
3. Container yards (ground-level, spread wide)
4. Sodium floodlight masts
5. Pallet/forklift props near loading docks
6. Perimeter fencing with warning placards (立入禁止)
7. Smokestack steam/heat shimmer vents
8. Rail siding stub with a parked freight car

**Reads as Tokyo because:** Keihin industrial belt (Kawasaki/Yokohama
shore) — chimney clusters, 立入禁止 placards, factory night views
(工場夜景) which are a genuine Tokyo-area photography genre; sentō-style
bathhouse chimney would be wrong here — these are industrial stacks.

**Mistakes to avoid:** flat unlit boxes (every shed gets window strips
or a floodlight); over-uniform road markings on the long straight
(B7); beacons as floating glow sprites (mount them on the stack tops,
pulse the material, no halo blobs); streaks on asphalt not tied to a
floodlight (B6).

---

## Circuit Beat Map (one lap)

| s | District | Beat |
|---|---|---|
| 0–470 | Start Plaza | **Launch** — bright, legible, full attack. The gantry says GO. |
| 470–1235 | Harbor West | **Breathe** — open yards, cool blue, visual tempo drops. Set up the line for the climb. |
| 1235–1502 | The Climb | **Build** — elevation, terraces, amber windows closing in. Tension rises with the gradient. |
| 1502–2285 | Bay Strait + bridge | **Soar** — the lap's peak. Open water, blue-lit towers, far-shore cranes. Apex at s ≈ 1899, y = 20: the highest, most exposed moment. |
| 2285–2573 | Waterfront East | **Exhale** — promenade calm, torii glow, downtown magenta bleeding on the horizon. |
| 2573–3573 | DOWNTOWN | **Overload** — maximum intensity. Signboards, pachinko tubes, air-train crossing overhead twice. The lap's sensory peak; hold the racing line through the noise. |
| 3533–4318 | South Ridge + tunnel | **Compress** — darkness, strips strobing past, the world narrows to the tube. Exit at s ≈ 4278 is the release. |
| 4318–4941 | Industrial Edge | **Cool down** — wide, orange, raw. Long straight to gather breath, chimney beacons counting down to the plaza. |

Rhythm in one line: **launch → breathe → build → soar → exhale → overload
→ compress → release → cool down.** Intensity peaks twice — the bridge
(elevation awe) and downtown (sensory overload) — separated by the
waterfront exhale so neither cheapens the other. The tunnel is the
anti-peak: a deliberate narrowing before the final straight opens up
again into the start/finish.
