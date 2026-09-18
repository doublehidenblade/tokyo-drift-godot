# Asset Shortlist — Tokyo Drift Godot

**HARD RULE: nothing is purchased without Craig's explicit approval.** This
doc exists so he can approve pack by pack. Do not download paid packs. Free
packs may be pulled for inspection only when clearly free-licensed.

Prices were verified 2026-09-18 via store search results; sales come and go —
re-confirm at checkout. Godot 4 compatibility is stated per pack: "native"
means a Godot project/scene ships in the download; otherwise the route is
Blender → FBX/glTF → Godot import.

## Priority 1 — must-have for the vertical slice

| Pack | Store / URL | Price | License | Godot 4 | Covers in our design | Fit concerns |
|---|---|---|---|---|---|---|
| JustCreate3D — Low Poly Sci-Fi Cyberpunk City | itch.io — https://justcreate3d.itch.io/low-poly-sci-fi-cyberpunk-city | **$19.99** (itch sale seen at $9.99; Unity/Fab ~$15–20) | itch asset license: commercial use in compiled games, no resale | FBX + **GLB included** → direct Godot import | Downtown towers (80 buildings), building parts, 57 street props, 12 vehicles, nature — the whole street-level look | Not Japan-specific; Japanese signage stays a custom texture task. Rating on Fab is thin (3.0/2 reviews) — inspect before approving |
| Synty — POLYGON Pro Racer | Synty Store — https://syntystore.com/products/polygon-pro-racer | **$60** (sale from $199.99) | Synty standard: commercial use in shipped games, no redistribution (verify at checkout) | **Native Godot 4.6.2+ project** ships + FBX sources | 9 customizable vehicles (**player race car** + traffic), modular grandstand + **tunnel sets**, drivers/pit crews | Cars are race-styled, not cyberpunk — fine for stylized, may want neon paint tweaks. Cheaper than Street Racer and more on-theme |
| Synty — POLYGON Town Pack | Synty Store (syntystore.com — search "POLYGON Town Pack") | **$49.99** | Synty standard (as above) | Native Godot 4.6.2+ project (all current Synty packs) | Streets, shops, houses, vehicles, **characters (pedestrians)**, props — fills Harbor/Start/Industrial districts | Daytime-styled; needs night/emissive treatment for our look |

**Must-have total: ~$129.98** (19.99 + 60 + 49.99).

**Alternative worth considering:** Synty subscription **from $30/mo** unlocks the
entire 130–150+ pack library (incl. Pro Racer, Town Pack, Sci-Fi City Pack).
If we expect to need 3+ Synty packs, one month of subscription beats buying
individually. Cancel anytime.

## Priority 2 — district depth / later milestones

| Pack | Store / URL | Price | License | Godot 4 | Covers | Fit concerns |
|---|---|---|---|---|---|---|
| Synty — POLYGON Sci-Fi City Pack | Synty Store | ~€45.99 (Unity Asset Store price seen; Synty Store price re-confirm) | Synty standard | Native Godot project | Sci-fi towers for the DOWNTOWN neon core | Overlaps Town Pack — buy only if downtown needs more height/variety |
| Synty — POLYGON Street Racer | https://syntystore.com/products/polygon-street-racer | $199.99 | Synty standard | Native Godot project | 1000+ prefabs, customizable vehicles, shipping dock | Expensive; Pro Racer covers our needs for the slice. Revisit only if vehicle variety becomes the bottleneck |
| Leartes Studios — SkyScrapers / High Rise Buildings (Cyberpunk Building) | Fab | $29.99 (sale from $59.99) | Fab standard license | Unreal/Unity-first → Blender FBX → Godot, materials rebuilt | Tall cyberpunk towers, closest to Craig's Leartes screenshot | Fab is Unreal/Unity marketplace; expect conversion work. Heavier AAA-leaning art — watch the mobile tri budget |
| Leartes Studios — Cyberpunk Environment Megapack | Fab / ArtStation | ~$149.99 (single env; bundle higher) | Fab/ArtStation standard | Same conversion route as above | Full cyberpunk city + vehicles + interiors | Cost + conversion effort + perf risk. Only if the slice proves we need this fidelity tier |
| JustCreate3D — Low Poly Cartoon Vehicles | itch.io (justcreate3d.itch.io) | $15 | itch asset license | FBX/GLB → Godot | Extra traffic variety | — |
| Neon Streets: Cyberpunk Food Stall & Street Clutter | itch.io — https://krishnamohan-yagneswaran.itch.io/neon-streets-cyberpunk-food-stall-street-clutter-pack-low-poly | price unverified | commercial use allowed (per page) | FBX/OBJ → Godot, flat-shaded | Noodle stalls, vending machines, neon utility poles — street-level flavor | Small pack (6 assets); price confirm at approval |
| Mnostva Art — Low Poly City Pack | ArtStation — https://www.artstation.com/marketplace/p/VgrqK/low-poly-city-pack-buildings-roads-urban-props | price unverified | ArtStation standard | FBX/OBJ/**GLB**; page lists Godot 3.4+ (import may need tweaks for 4.x) | 106 modular assets, one material — cheap to render | Compatibility is 3.x-era; verify import before approving |

**Not found in any pack: a suspension bridge.** No shortlist pack covers one.
Plan: build the bridge procedurally/from primitives in Godot (towers, cables,
deck) — it's a signature asset, worth authoring once.

## Priority 0 — free first (prototype with $0)

Pull these now; they cost nothing and unblock the vertical slice's
driveability/layout work while purchase approvals are pending.

| Pack | URL | License | Godot 4 | Use for |
|---|---|---|---|---|
| Synty — POLYGON Starter Pack | https://syntystore.com/products/polygon-starter-pack | Synty free | **Native Godot 4.6.2 project** | Props/characters/vehicles to stand in while paid packs are decided |
| ansimuz — Synth Cities Environment | https://ansimuz.itch.io/cyberpunk-street-environment/purchase | free / pay-what-you-want | **SynthCitiesGodot.zip — native Godot** | Immediate cyberpunk street block for the first drivable test |
| Kenney — City Kits (Commercial/Suburban/Industrial/Roads) + Car Kit + Racing Kit | https://kenney.nl/assets | **CC0** (public domain) | **GLB direct import** | Layout prototyping, traffic cars, road pieces |
| Quaternius — Cars, Nature | https://quaternius.com/packs/cars.html (cars; other packs on quaternius.com) | **CC0** | FBX/GLB → Godot | Extra traffic cars, trees |
| KayKit — City Builder Bits (free tier) | https://kaylousberg.itch.io/city-builder-bits | **CC0** | **glTF direct import** | Buildings, roads, cars, street furniture (32+ models free) |

**Fit note on the free tier:** Kenney/KayKit/Quaternius are toy-blocky, not
neon-cyberpunk. That's fine for the prototype (layout, driving, harness),
but the shipped look comes from the Priority 1 packs. One style family per
district once paid packs land — don't mix toy and neon in the same street.

## Open verification items (need a browser at approval time)

- Leartes' Gumroad Godot-ready offerings: Craig's screenshot was Leartes on
  Gumroad; search confirmed their Fab/ArtStation storefronts but not the exact
  Godot-ported pack URLs. Verify the Godot version + price before approving
  any Leartes purchase.
- Re-confirm every price at checkout (sales rotate; Pro Racer's $60 and the
  itch $9.99 sightings are sale prices).
