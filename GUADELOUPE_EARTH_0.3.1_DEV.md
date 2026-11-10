# Guadeloupe Earth 0.3.1-dev — diagnostic performance pass

## Purpose
This is a diagnostic continuation of 0.3.0-dev, not a claim that in-game freezes are fixed. The existing engine already has persistent revisit storage for completed road/geometry products, ahead-of-player downloads, separate road/building/far-field worker pools, adaptive memory/CPU budgeting, and background pacing. Changing worker counts without observing the user's machine could make frame stalls worse.

## Changes
- Startup now logs the effective download-cache limit, whether the built-world revisit cache is enabled, its effective size limit, and the absolute cache directory. This makes it possible to verify that routes/road products can persist between server sessions and that the user is not accidentally running two different cache roots.
- Added `run_server_diagnostics.bat`. It starts the normal server with verbose event-loop diagnostics and writes the full log to `%USERPROFILE%\\Desktop\\Guadeloupe-Earth-diagnostic.log`.
- No world-generation algorithms, worker counts, or map zoom limits were changed in this diagnostic pass. Avoids speculative performance regressions.

## How to diagnose
1. Start BeamNG with `run_server_diagnostics.bat` instead of `run_server.bat`.
2. Drive through a new area until a freeze occurs, then revisit a previously driven area and reproduce it if possible.
3. Stop the server with Ctrl+C after the test.
4. Inspect/share `Guadeloupe-Earth-diagnostic.log`. It contains server timing and event-loop stall stacks; it does not capture BeamNG's GPU/physics frame timings.

## Next optimization decision
Use the log to separate event-loop stalls, road-worker backlog, downloads, and far-tile work. If the server loop is not stalling while the game freezes, capture BeamNG's `beamng.log` and UI/Lua logs next; the remaining bottleneck is likely in the game-side shape/terrain upload or rendering path. Runtime verification is still required.
