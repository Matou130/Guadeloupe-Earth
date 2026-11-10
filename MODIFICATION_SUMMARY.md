# Guadeloupe Earth — relevé de migration (préversion 0.1.0)

Cette archive est une **préversion de migration du code source**, pas une version finale jouable et validée dans BeamNG.drive.

## Amélioration fix14 — orthophotos et largeurs de chaussée IGN

- Les photos aériennes IGN BD ORTHO de Guadeloupe sont prioritaires sur Sentinel-2 et disponibles jusqu’au zoom 19. Les tuiles visitées sont gardées dans le cache pour le mode hors ligne.
- Les largeurs de chaussée mesurées dans la BD TOPO sont utilisées lorsque la géométrie de la route générée correspond suffisamment à celle de l’IGN. Les autres routes gardent leur largeur connue ou estimée.
- La console affiche maintenant `Server generator revision: fix14`.

## Amélioration fix13 — bâtiments IGN en Guadeloupe

- La couche des bâtiments en Guadeloupe utilise maintenant les polygones du service WFS BD TOPO de l’IGN (`batiment`).
- Le générateur reprend les hauteurs, le nombre d’étages et les matériaux des murs/toits lorsqu’ils sont renseignés. Les attributs absents restent traités par les règles procédurales existantes.
- La couverture IGN des altitudes de routes a été étendue à la Guadeloupe. Les hauteurs mesurées des routes, ponts et tunnels guident la géométrie lorsque la source en fournit et que les segments correspondent.
- Les cellules sont écrites dans un cache distinct et restent utilisables hors ligne après leur premier téléchargement. Si le service IGN est indisponible, la génération retombe sur Overture.
- Au démarrage, la console indique `Server generator revision: fix13`.

## Modifications effectivement intégrées

### Identité et packaging

- Dossier du mod : `mod/beamng_earth/` → `mod/guadeloupe_earth/`.
- Niveau : `levels/beamng_earth/` → `levels/guadeloupe_earth/`.
- Extensions Lua : `beamngEarth` → `guadeloupeEarth`.
- Composants Vue et applications UI déplacés sous `guadeloupeEarth` / `GuadeloupeEarth*`.
- Chemins de cache et de session isolés sous `guadeloupe-earth` et `guadeloupeEarth`.
- L'ancienne intégration d'annuaire public BeamNG.Earth et les mises à jour automatiques upstream sont désactivées.
- Aucun `modinfo.json` n'existait dans l'archive fournie : le fichier de métadonnées du niveau BeamNG utilisé est `levels/guadeloupe_earth/info.json`.

### Politique géographique

- Nouveau module serveur : `server/guadeloupe_region.py`.
- Miroirs Lua et JavaScript : `lua/ge/extensions/guadeloupeEarth/region.lua` et `ui/ui-vue/mods/guadeloupeEarth/guadeloupeRegion.js`.
- Emprise de travail : 15.80–16.55° N, 61.85–60.95° W.
- Validations au niveau serveur pour la création d'ancres, les itinéraires, la recherche géographique et les demandes de tuiles.
- Filtrage des tuiles cartographiques et satellite avant accès cache/réseau, y compris les sous-tuiles écrites lors du découpage d’une tuile parent ; filtrage des cellules de données avant lecture/construction des couches, des tuiles DEM, des échantillons hors emprise, des tuiles géographiques et des tuiles de champ lointain.
- Les fonctions de projection Web Mercator et de géométrie génériques restent génériques ; elles ne déclenchent pas seules de téléchargement. Le filtrage est placé sur les frontières d'accès aux données.

### Lieux de départ et interface

- `places.lua` : neuf lieux guadeloupéens au lieu des destinations mondiales ; les lieux enregistrés hors emprise et les anciennes destinations mondiales sont rejetés à la lecture.
- `core.lua` : position de démarrage régionale par défaut et rejet des téléportations/rebases hors emprise.
- `levelinfo.lua` et `info.json` : liste de sélection régionale ; identifiants `gue_place_1` à `gue_place_9`.
- `EarthMap.vue` : centre initial sur l'archipel, déplacement/points/itinéraires/requêtes de tuiles limités à l'emprise.
- `EarthWelcome.vue` : message d'accueil Guadeloupe Earth et pictogramme schématique d'archipel.
- `index.js`, paramètres, applications UI et tableau de bord renommés.

### Données et services externes

- Le moteur de génération, les projections et les connecteurs de données du projet d'origine restent présents.
- Le cache du fork est indépendant.
- L'annuaire public et la vérification des mises à jour de l'ancien projet sont désactivés.
- Le module de tags ferroviaires tiers est désactivé par défaut ; il ne s'active que si une source de données est configurée explicitement.
- BeamMP reste optionnel et limité à des positions dans l'emprise ; aucune liste publique de serveurs n'est configurée.

## Lieux proposés (coordonnées indicatives)

| Lieu | Latitude | Longitude |
|---|---:|---:|
| Pointe-à-Pitre | 16.2415 | -61.5330 |
| Basse-Terre | 15.9970 | -61.7290 |
| Capesterre-Belle-Eau | 16.0450 | -61.5650 |
| Aéroport Pôle Caraïbes | 16.2650 | -61.5310 |
| Saint-François | 16.2520 | -61.2730 |
| Deshaies | 16.3060 | -61.7950 |
| Grand-Bourg, Marie-Galante | 15.8830 | -61.3150 |
| Terre-de-Haut, Les Saintes | 15.8670 | -61.5830 |
| La Désirade | 16.3080 | -61.0800 |

Ces coordonnées ne sont pas encore recalées sur une voie praticable ni validées en jeu. Le menu du niveau contient un SpawnSphere physique par défaut ; les neuf lieux nommés supplémentaires sont des entrées de téléportation dynamiques, et non neuf objets SpawnSphere déjà matérialisés.

## Contrôles réalisés

- `compileall` Python sur serveur, installateur, launcher et outils : réussi.
- Tests ciblés : 40 tests de région/carte/protocole/rapports/mise à jour réussis, dont le refus des tuiles satellite hors zone avant tout accès réseau/cache.
- Tests des tags ferroviaires : 4 tests réussis.
- Tests supplémentaires géotuiles, champ lointain, DEM et mapdata : 127 tests exécutés, réussis, 34 ignorés car prérequis optionnels absents.
- Sous-ensembles déterministes de `test_imagery.py` (reprojection, chaîne synthétique, export, textures et DDS) : 40 tests réussis.
- Total des tests terminés : 212 exécutés, 178 réussis et 34 ignorés (ces derniers sont explicitement marqués comme skip par les suites).
- La suite intégrale `server.tests.test_imagery` a dépassé le délai d’exécution ; les trois tests qui contactent de vrais fournisseurs d’imagerie ne sont donc pas déclarés validés.
- Vérification syntaxique Node des modules `guadeloupeRegion.js` et `index.js` : réussie.
- Test Node `mod/tests/test_mapmath.mjs` : réussi.
- `install.py --help`, `start.py --help` et validation JSON du `info.json` : réussis.

Non vérifiés : syntaxe Lua dans le moteur, compilation Vue par l'interface BeamNG, chargement effectif du niveau, conduite, streaming en jeu, BeamMP et performances. Aucun runtime BeamNG.drive ou interpréteur Lua n'était disponible pendant cette migration.

## Travail indispensable avant publication

1. Remplacer l'emprise rectangulaire par un multipolygone terrestre guadeloupéen vérifié et une règle de marge côtière.
2. Générer ou intégrer les données DEM, orthophoto, littoral, routes, ponts, bâtiments et végétation propres à l'archipel. La présente préversion ne fabrique pas ces jeux de données.
3. Recaler chaque destination sur une voie réelle et valider hauteur, orientation, collision et accès véhicule.
4. Produire une véritable image d'aperçu Guadeloupe et des textures/reliefs du niveau au lieu des anciens assets génériques.
5. Valider le dossier unpacked, les scripts Lua, l'UI Vue, le serveur compagnon et le multijoueur dans la version exacte de BeamNG.drive ciblée.
