# Art Reference — Tokyo Drift (Godot)

Mood/visual reference pulled from the web build’s `tokyo-drift-3d/art-reference/`.
**Consult these during 2D city planning, storyboarding, mock generation, and 3D model
design** — they define the target look before any geometry is built.

## Sets

- `retro-tokyo-80s/` (7 images) — the primary target aesthetic: 80s anime / synthwave /
  city-pop night Tokyo. Drift city anime still, synthwave street racer painting,
  city-pop car, rainy rooftop anime scene, Tokyo Tower at dusk (anime), Night Tempo
  city-pop vinyl poster (Tengenji/Ginza), synthwave street-racer painting.
- `tokyo-night-real/` (6 photos) — real night photography for grounding: sakura street,
  Shibuya crossing, Rainbow Bridge highway, waterfront skyline, tunnel night run,
  Rainbow Bridge night lights. Use for lighting mood, signage density, road feel —
  not for copying directly.
- `craig-phone-qa-2026-09-18/` (8 screenshots) — Craig’s Samsung QA captures from the
  web build: the B1–B7 bug set (black walls, bridge rails, building in road, ghost
  cars, tunnel flares) plus Godot race-car-controller and cyberpunk-city references.
  Anti-reference: things the 3D city must NOT repeat.

## Filename audit (2026-09-18)

Two files were misfiled under `tokyo-night-real/` in the source repo and have been
moved to `retro-tokyo-80s/` here (original filenames preserved, renumbered 06/07 to
avoid a duplicate `05`):

- `06-citypop-poster-tengenji-ginza.jpg` — Night Tempo city-pop vinyl poster art
- `07-synthwave-street-racer.jpg` — synthwave digital painting

Both are stylized retro art, not real night photography. Everything else checked out:
the remaining `tokyo-night-real/` files are real photos, the `retro-tokyo-80s/` files
are all anime/synthwave-styled.

Excluded: `workspace/user/files/22168_14_bgri.jpg` — a phone screenshot of a GitHub
`src/` file listing, not art reference.

## Rules

- Reference only — never ship these images (or crops of them) as in-game textures.
- AI concept art generated FROM these goes in `docs/city-design/concepts/` and is
  always labeled as concept/AI work, never presented as final or designer art.
