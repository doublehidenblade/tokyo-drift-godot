# PLANNING_LANGUAGE.md — Reference planning language (CGTrader study)

Craig: "that's the kind of city planning I want." Studied two CGTrader products for
their *planning language* — how they organize a city — not to buy them.

Sources (studied 2026-09-18):
- **Urban City Kitbash Set** (DenisRutkovsky, $44.99, 235 unique meshes) — full city
  blocks of mid/high-rise towers as **snap-together modular pieces**; wide multi-lane
  arterials plus an **elevated highway/overpass cutting through** the district;
  very high density glass-and-concrete towers with varied massing/heights;
  street-level retail fronts under towers; banners, traffic lights, cars on
  sidewalks; **construction cranes**; golden-hour street-canyon shots with lit
  billboards.
  https://www.cgtrader.com/3d-models/architectural/architectural-street/urban-city-kitbash-set-ue4
- **Japanese City — Midtown** (nimikko, $174.30, 60+ buildings, ~1 km × 600 m) —
  regular urban grid; **tight tower-in-plaza highrise cluster ringed by 5–10 storey
  mid-rise blocks**; multi-lane arterials with **zebra crossings and signalized
  intersections**; collector roads framing blocks with **green strips/parks at
  edges**; commercial podium/retail frontages; Japanese identity via vertical
  kanji/katakana signage, shopfront signs, Japanese traffic signals, street lamps,
  **overhead utility wires**, street trees; **rooftop penthouses/mechanical units**
  varying the skyline.
  https://www.cgtrader.com/3d-models/exterior/cityscape/japanese-city-midtown-environment
- Supporting: Midtown City (Kasiopy) modular city — 100 m × 100 m road tiles / city blocks.

## The 9 planning takeaways we adopt

1. **Block-first planning.** The city is subdivided into ~80–150 m superblocks bounded
   by arterials; the BLOCK is the unit of placement, not the building. (Midtown City
   makes it explicit: 100 m × 100 m tiles.) Every district gets a block map with
   dimensions before any geometry is placed.

2. **Snap-together modular assembly (the kitbash lesson).** The kitbash set's value is
   not 235 meshes — it is that blocks are built from *repeating composable parts*:
   tower slabs, podium bands, corner retail pieces, rooftop units, parapets. We
   mirror this procedurally: a small kit of parametric block parts (podium block,
   tower shaft, setback tier, rooftop unit, parapet) that snap together to assemble
   every block, so blocks look *designed* while the builder stays fast and $0.

3. **Street hierarchy, not a uniform grid.** Arterials (12–16 m) define block edges;
   side streets (6–10 m) split blocks internally; alleys / yokocho (3–5 m) give
   Japanese texture. The kitbash set is a *constructor*: streets first, kit parts fill
   blocks after. Intersections are *designed*: **zebra crossings** on arterial
   approaches, **signalized intersections** (signal poles + heads, Japanese-style
   gantry signals on wide arterials) at major junctions. Our arterial table
   (CITY_LAYOUT §10) is the street plan; blocks are filled from it.

4. **Tower-in-plaza ringed by mid-rise: peak-and-fabric made concrete.** The Midtown
   pack gives the exact pattern: a **tight tower-in-plaza highrise cluster** (peaks
   35–90 m, loose within-block siting with plaza gaps between towers) **ringed by
   5–10 storey mid-rise blocks** (the fabric, 15–35 m, built to the block edges).
   This is takeaway #3 in the old draft, now concrete: towers do NOT fill block
   edges — they sit back in the block with hardscaped plaza at their feet;
   the mid-rise fabric fills to the lot lines around them. Downtown is our peak
   (tower-in-plaza cluster around the Spire); every other district is fabric at its
   own deliberate height band, ringed around the peak.

5. **Commercial podium band at street level, everywhere it fits.** Both packs do
   this: towers rise out of a 1–3 storey **podium / retail frontage** whose ground
   floor is continuous shopfront — kanban, noren, glowing bands — rather than a
   bare tower dropping straight to the sidewalk. Vertical layering now reads
   podium (1–2 storeys, retail, dense signage) → tower shaft → rooftop.

6. **Rooftop dressing as skyline-variation rule.** Midtown varies the skyline not
   with more towers but with **rooftop penthouses and mechanical units**: penthouse
   boxes, AC plants, tanks, antenna masts, railing — each roof gets a different
   combination. This is a hard rule now: no bare flat roof on any block, any tier;
   rooftop units are the cheapest skyline variation available, and they read from
   every racing sightline.

7. **Japanese identity = signage + clutter density, not architecture style.** What
   reads as Tokyo in these packs: **vertical kanji/katakana signboards**, dense
   narrow shopfronts, **overhead utility poles and sagging wires**, **street trees**
   lining arterials, **Japanese traffic signals** (gantry + pole-mounted heads),
   vending machines, noren, roof equipment. The Tokyo read lives in the
   signage/clutter layer — which is why our standing rule (every sign physically
   mounted, no floating signs) is a planning constraint, not just a rendering rule.

8. **Verticality through infrastructure, not decor.** The kitbash set's boldest move:
   the **elevated highway/overpass cutting through** the district — verticality that
   the city is *built around*. Our city has two of these already: the elevated
   expressway over Harbor West (§10 arterial, crossing the circuit at s≈869) and the
   air-train viaduct threading downtown. Treat them as infrastructure spines —
   blocks align to them, corridors stay clear, they silhouette above the fabric —
   never as decoration added after.

9. **Construction crane as the vertical accent.** The kitbash set plants construction
   cranes for vertical interest — a tower crane (jib + counter-jib, lit aviation
   beacon on top) reads from any sightline and implies a growing city. Downtown and
   any fabric district get one crane each, sited at a vista terminus (takeaway #10),
   never inside the racing corridor.

## The 10th: landmarks at decision points and vista termini (kept from the draft)

Landmarks sit where eyes go: intersections of arterials, the end of a long straight,
above the fabric so they silhouette. For a racer, that means: on the driver's
sightline through/after corners, never hidden behind fabric, never inside the
racing corridor.

## Distilled checklists (fold into block builders)

- **Every block:** podium band (1–2 storeys, retail frontage) OR explicit reason it
  has none (industrial/yard blocks); rooftop penthouse/mechanical variation; one
  street-tree rhythm on arterial edges; signal poles + zebra crossing where an
  arterial junction touches the block.
- **Every district:** one tower-in-plaza cluster OR fabric ring around the
  district's own peak; **green strip / park at the district edge** (collector road
  framing, planting, seating — even at Tier 2 fidelity); one vertical accent
  (crane, chimney, spire); one block where construction is visibly unfinished.
- **Lighting mood (translate, don't copy):** the references are golden-hour
  street-canyon shots with lit billboards; our city is night-neon. The translation
  is: keep their **density of lit surfaces at street level** (every billboard lit,
  shopfronts glowing) and their **long-shadow canyon read** — replace warm sun
  with cyan/magenta facade tubes + warm-white shopfront spill, keeping the same
  rule: no dead dark facades facing the racing line.

## Why we do NOT buy them (take the language, not the product)

- **They are street-level dioramas, not racing circuits.** Built for walkthrough
  camera renders and showcase stills. No circuit routing, no lap flow, no gameplay
  sightlines (our B-rules: road clearance audits, sign mounting, sightline beats).
- **Polygon budget is absurd for us.** The Midtown pack is 77.3 M polygons with
  2.26 GB of textures — the opposite of fast-iteration Godot/WebGL-friendly art.
  Our proof-of-concept needs lightweight procedural kitbash, not PBR dioramas.
- **Wrong pipeline.** BLEND/FBX drops with gigabyte texture folders; our builder is
  procedural and must obey our mounting/clearance/reflection rules, which bought
  geometry does not.
- **$0 constraint.** Midtown is $249; the kitbash set is $44.99. Craig is NOT
  buying them. Budget stays zero.
- **What we keep:** block structure, snap-together modular assembly, street
  hierarchy with designed intersections, tower-in-plaza ringed by mid-rise,
  commercial podiums, rooftop-dressing rules, landmark placement logic, the
  Japanese-identity clutter vocabulary, infrastructure-spine verticality, green
  strips at edges, construction-crane accents. That is the planning language —
  it is free.
