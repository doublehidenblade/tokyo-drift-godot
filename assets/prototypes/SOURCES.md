# Prototype Asset Sources — Tokyo Drift (Godot 4.7)

All packs below are $0 / free-licensed. **Download status (2026-09-18): none could be
pulled by automated page-fetch** — see per-pack notes. A real-browser task (or Craig
clicking the links) can complete the downloads; every link below is free and login-free
except Synty (free $0 checkout, account required).

| Pack | URL | License | Godot 4 import path | Download status |
|---|---|---|---|---|
| Synty — POLYGON Starter Pack | https://syntystore.com/products/polygon-starter-pack | Synty free tier (standard Synty license: commercial use in shipped games, no redistribution — verify at checkout) | **Native Godot 4.6.2 project** ships in the download — unzip, open `project.godot` in Godot 4.6.2+ | BLOCKED: free ($0.00 variant) but requires Synty Store checkout + account; no unauthenticated direct URL |
| ansimuz — Synth Cities Environment | https://ansimuz.itch.io/cyberpunk-street-environment (free files at `…/purchase` → "No thanks, just take me to the downloads") | Free / pay-what-you-want (per itch.io page) | **SynthCitiesGodot.zip (7.6 MB) — native Godot project**; unzip and open in Godot 4.x (may prompt upgrade on 4.7). `cyberpunk-street-files.zip` (15 MB) = source files. Do NOT take `SynthCitiesFiles.zip` — that's the $5.00 paid tier | BLOCKED: itch.io `/download` page not reachable by automated fetch (needs JS/session); works in a real browser, no login needed |
| Kenney — City Kit (Commercial) | https://kenney.nl/assets/city-kit-commercial | **CC0** (public domain, confirmed on page) | GLB direct import — drag `.glb` files into Godot 4 FileSystem (pack also ships FBX/OBJ) | BLOCKED: per-kit download sits behind the interactive donate-wall ("Continue without donating"); no static file URL in page text |
| Kenney — City Kit (Suburban) | https://kenney.nl/assets/city-kit-suburban | **CC0** | GLB direct import (same as above) | BLOCKED (same donate-wall flow) |
| Kenney — City Kit (Industrial) | https://kenney.nl/assets/city-kit-industrial | **CC0** | GLB direct import (same as above) | BLOCKED (same donate-wall flow) |
| Kenney — City Kit (Roads) | https://kenney.nl/assets/city-kit-roads | **CC0** | GLB direct import — road/rail pieces for layout prototyping | BLOCKED (same donate-wall flow) |
| Kenney — Car Kit | https://kenney.nl/assets/car-kit | **CC0** | GLB direct import — traffic-car stand-ins | BLOCKED (same donate-wall flow) |
| Kenney — Racing Kit | https://kenney.nl/assets/racing-kit | **CC0** | GLB direct import — cones/barriers/track bits | BLOCKED (same donate-wall flow) |
| Quaternius — Cars Pack | https://quaternius.com/packs/cars.html | **CC0** ("Free Game Assets"; license badge on pack page) | Pack ships **FBX / OBJ / Blend** → FBX direct-imports into Godot 4 (uFBX/FBX2glTF), or round-trip through Blender → glTF | BLOCKED: "Just give me the Download" href not exposed in page-text extraction; direct file URL pattern unconfirmed |
| Quaternius — Nature Pack | https://quaternius.com/ (pack index; nature packs listed: Ultimate/Stylized/Simple Nature) | **CC0** | Same FBX→Godot route as Cars | BLOCKED (same as Cars) |
| KayKit — City Builder Bits (FREE tier) | https://kaylousberg.itch.io/city-builder-bits | **CC0** — "Free for personal and commercial use, no attribution required" (confirmed on page) | Ships **.OBJ + .FBX + .GLTF** → **glTF direct import** into Godot 4. Free tier = 32+ models. Do NOT take EXTRA ($3.95+) or SOURCE ($5.95+) tiers | BLOCKED: itch.io `/download` page not reachable by automated fetch; free in a real browser, no login needed |

## Fit caveat (from the shortlist, restated)

Kenney / KayKit / Quaternius are **toy-blocky, not neon-cyberpunk** — correct for
layout + driveability + harness prototyping, wrong for the shipped look. Keep one
style family per district once paid packs land; do not mix toy and neon on the same
street. ansimuz Synth Cities is the one free pack that already reads cyberpunk and is
the best first-block candidate for the initial drivable test.

## Japan City pack (CGTrader) — NOT downloaded

Verdict recorded in `japan-city/NOT_DOWNLOADED.md`. Paid commercial pack — no
download per the $0 hard rule.
