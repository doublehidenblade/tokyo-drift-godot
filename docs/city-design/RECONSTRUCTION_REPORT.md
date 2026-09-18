# Image-to-3D Reconstruction Experiment — Report

**Date:** 2026-09-18 · **Tool tested:** TripoSR (VAST-AI-Research, open weights, $0)
**Verdict up front:** the free single-image-to-3D path is **not good enough for hero landmarks**.
A torii gate came out usable only as a distant background prop; Tokyo Tower came out unusable.
For simple geometric subjects like a torii, ~10 minutes of hand-modeling from Godot/Blender
primitives beats the reconstruction on every axis. Do not bet the art pipeline on this path.

## What was tried

- **TripoSR** (stabilityai/TripoSR weights, image → textured mesh, default vertex-color output).
  - Hunyuan3D-2 was *not* attempted: it needs a GPU and far more RAM/time than this
    environment has (2 CPU cores, 7 GB RAM, no CUDA). On this box it would exceed the
    45-minute-per-run timebox by a wide margin. If Craig wants Hunyuan3D-2 evaluated,
    it needs a GPU machine.
- **Reference images** were generated clean on plain backgrounds (best case for reconstruction):
  [torii gate](sandbox://workspace/tokyo-drift-godot/assets/prototypes/reconstructed/refs/torii-gate-ref.png)
  (vermilion, front 3/4, white bg) and
  [Tokyo Tower](sandbox://workspace/tokyo-drift-godot/assets/prototypes/reconstructed/refs/tokyo-tower-ref.png)
  (dusk, front, dark bg).
- Background removal via rembg (u2net) was clean on both — segmentation is not a confounder.
- Marching-cubes resolution 256 (TripoSR default). Default vertex-color output
  (the `--bake-texture` atlas path needs a GL context + xatlas and was not exercised headless).

## Environment notes (for reproducibility)

Getting TripoSR running on this box was itself informative about the path's fragility:

- `huggingface.co` front-door downloads ran at **~1.3 KB/s** (a ~1.56 GB checkpoint would take
  days). The signed CDN URLs it redirects to (`us.aws.cdn.hf.co`) ran at ~1.4 MB/s — weights
  were fetched by following redirects directly with curl. `hf_hub_download` stalled at 0 bytes.
- `/tmp` is a 512 MB tmpfs — all tooling lives in `~/workspace/.img3d/` (venv, weights,
  torchmcubes build). Safe to delete when done.
- Fixes needed: `pip install --no-build-isolation` + `pybind11` for torchmcubes' CMake build;
  a one-line NumPy 2.0 compat patch in trimesh 4.0.5 (`ndarray.ptp()` removed);
  stub modules for `xatlas`/`moderngl` (imported unconditionally by `run.py`, never called
  without `--bake-texture`).
- Per-run wall time on 2 CPU cores: **~5 min** (model init ~27 s, inference ~100 s,
  mesh extraction ~150 s). Cheap per-run — but quality is the problem, not speed.

## Results

### 1. Torii gate — [mesh GLB](sandbox://workspace/tokyo-drift-godot/assets/prototypes/reconstructed/torii_gate_triposr.glb) · [8 views](sandbox://workspace/tokyo-drift-godot/assets/prototypes/reconstructed/torii_gate_views.png)

| Metric | Value |
|---|---|
| Triangles / vertices | 48,548 / 24,308 |
| Watertight | No (open mesh) |
| UVs / texture atlas | None — vertex colors only (no UVs, no texture PNG) |
| "Texture resolution" | Effectively the vertex density: fine for flat vermilion, useless for wood-grain detail |
| Topology | Winding-consistent but lumpy; beams/pillars fused rather than cleanly joined |

**Novel views:** from the front it reads as a torii silhouette (two pillars, two beams).
The signature curved top beam (kasagi) with upturned ends is muted/lost — the most
recognizable part of a torii. The back side, unseen in the reference, is dark muddy
gray-brown (classic single-view hallucination). Colors overall skew dark, not vermilion.

**Verdict: background prop only.** Acceptable as a distant roadside silhouette in a night
race; falls apart on any close inspection. Not hero quality. And note: a torii is two
cylinders + two boxes + one curved beam — hand-modeling it in Godot takes ~10 minutes and
produces a cleaner, watertight, properly vermilion asset with real materials. The
reconstruction loses to primitives here.

### 2. Tokyo Tower — [mesh GLB](sandbox://workspace/tokyo-drift-godot/assets/prototypes/reconstructed/tokyo_tower_triposr.glb) · [8 views](sandbox://workspace/tokyo-drift-godot/assets/prototypes/reconstructed/tokyo_tower_views.png)

| Metric | Value |
|---|---|
| Triangles / vertices | 27,360 / 13,715 |
| Watertight | No |
| UVs / texture atlas | None — vertex colors only |
| Topology | Melted blob; no lattice members resolved |

**Novel views:** total failure. The lattice structure collapsed into an unrecognizable
melted mass with spikes — it does not read as Tokyo Tower (or any tower) from any angle.
Colors are muddy dark red/brown. This is the expected architectural limit: TripoSR's
256³ marching-cubes grid cannot resolve sub-voxel thin lattice members, so they fuse
into a blob. No parameter tweak fixes this; it's inherent to single-view density-field
reconstruction at this resolution.

**Verdict: unusable.** A Tokyo Tower landmark will need to be modeled (or bought in a pack).

## Evaluation method

No GPU/blender/Godot rendering available on this box, so views are orthographic
software renders (vertex colors × lambert shading) at 8 azimuths from the exported GLB,
generated by `~/workspace/.img3d/eval_mesh.py`. Geometry artifacts (melted backs, fused
members) are fully visible in shaded renders; this is a fair test of the classic
"looks fine from the reference angle, falls apart elsewhere" failure mode.

## Bottom line for the art pipeline

1. **Do not use free single-image-to-3D for the Japan landmarks.** Torii = background-prop
   grade at best; Tokyo Tower = unusable. Hunyuan3D-2 might do better but needs a GPU box
   to even evaluate.
2. **Simple subjects: model from primitives.** A torii from cylinders/boxes will look better
   than the reconstruction and take minutes, with clean topology and real materials.
3. **Complex subjects (Tokyo Tower): buy or commission.** No pack on the shortlist covers it;
   the free path can't produce it. Keep it on the purchase/approval list.
4. The experiment cost $0 and ~40 min of machine time (mostly downloads/compiles); the two
   GLBs, view sheets, and stats JSONs are kept under
   `assets/prototypes/reconstructed/` as reference for what the free path yields.

## Files

- `assets/prototypes/reconstructed/torii_gate_triposr.glb` (+ `_views.png`, `_stats.json`)
- `assets/prototypes/reconstructed/tokyo_tower_triposr.glb` (+ `_views.png`, `_stats.json`)
- `assets/prototypes/reconstructed/refs/` — the two reference images (PNG + original WEBP)
- `~/workspace/.img3d/` — scratch tooling (venv, weights, build scripts); deletable
