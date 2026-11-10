# Guadeloupe Earth — source preview

Guadeloupe Earth is a geographically restricted fork of BeamNG.Earth. This preview keeps the original companion-server architecture and restricts supported in-game locations and source-data requests to a Guadeloupe working envelope. It is **not yet a finished, game-validated map release**.

## Included in this preview

- A shared geographic policy in `server/guadeloupe_region.py`, mirrored in Lua and Vue configuration.
- Server-side rejection/filtering for out-of-envelope anchors, route requests, map tiles, DEM requests, map-data cells and geotiles.
- A Guadeloupe-specific saved-place seed and level-select entries for Pointe-à-Pitre, Basse-Terre, Capesterre-Belle-Eau, Pôle Caraïbes airport, Saint-François, Deshaies, Grand-Bourg, Terre-de-Haut and La Désirade.
- A Guadeloupe-centred map view and locally scoped caches. Persistent downloads, decoded terrain/map-data mirrors, generated road tiles and other disk caches have no software size cap by default; disk capacity remains the practical limit. RAM caches stay bounded for stability.
- Guadeloupe IGN BD ORTHO aerial photos take priority over lower-detail satellite imagery when available. They are downloaded on demand and kept in the cache for offline use.
- IGN BD TOPO road widths and elevations are used where measured and matched to generated road segments; the existing estimates remain the fallback.
- Upstream update checks and the old public BeamNG.Earth server directory disabled.

## Important geographical limitation

The current limits (`15.75..16.60 N`, `-61.95..-60.90 W`) are a **rectangular working envelope**, not an authoritative coastline or administrative boundary. They include sea between islands and some sea outside the coastline. A production release should replace or refine the rectangle with an authoritative multipolygon and a deliberate coastal buffer. The spawn coordinates are indicative geographic positions, not yet snapped to verified drivable road lanes.

## Requirements and installation

The BeamNG mod files are under `mod/guadeloupe_earth/`. For an unpacked-mod test, copy the contents of that directory into BeamNG.drive's `mods/unpacked/guadeloupe_earth/` folder. This source repository also contains the companion server and its original build tooling; follow the project setup documents after checking their prerequisites. `install.py` is retained as the installer entry point.

The game must be closed before replacing mod files. The companion server requires the Python packages listed in `server/requirements.txt` and the compatible native `earthfast` extension supplied/built for the target platform.

## Offline and cache behaviour

The companion server reuses downloaded data and complete generated road tiles from the cache between sessions. Persistent disk caches are unlimited by default (no automatic LRU or per-folder quota); only available disk space limits them. The generated-world cache is also kept without an automatic size cap, and compatible route tiles from the 0.2.0-dev / 0.2.1-dev packages are read by this retention-only update. RAM caches deliberately remain bounded to avoid exhausting system memory. Offline mode can use only data already cached; missing data still requires a network connection. Unlimited cache does not pre-download the whole archipelago.

## What is not included yet

- No orthophoto mosaic is bundled in the archive. IGN photos and building data are fetched on demand and cached. A new DEM, coastline mask or complete roads/vegetation dataset is not bundled.
- Generic worldwide projection and geometry algorithms remain in the code; they are reusable mathematics, not proof of worldwide content access. Requests reaching data-generation boundaries are restricted by the Guadeloupe policy.
- Real in-game validation, Lua runtime validation, BeamMP multiplayer testing and performance testing have not been completed.
- The nine named destinations are available through the level's dynamic place/spawn selection. The level still has a single physical `SpawnSphere`; the other menu entries are teleports backed by saved-place IDs, not nine separately validated physical spawn objects.

See [`GUADELOUPE_EARTH_PREVIEW.md`](GUADELOUPE_EARTH_PREVIEW.md) for the migration notes and remaining work.

## Diagnostic performance build (0.3.1-dev)

For investigating freezes, use `run_server_diagnostics.bat` instead of `run_server.bat`. It saves verbose server diagnostics to the Windows Desktop as `Guadeloupe-Earth-diagnostic.log`. This build also logs the active persistent-cache configuration and cache directory at startup. It does not claim to fix game-side frame stalls; see `GUADELOUPE_EARTH_0.3.1_DEV.md`.
