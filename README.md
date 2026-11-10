# Guadeloupe Earth 

Guadeloupe Earth est une version de BeamNG.Earth limitée à une zone de travail autour de la Guadeloupe. L’interface du mod est maintenant en français par défaut. Cette préversion n’est pas encore une carte finalisée et validée en jeu.

## Contenu

- Une zone géographique commune définie dans `server/guadeloupe_region.py` et reprise dans les scripts Lua et Vue.
- Un filtrage des demandes de terrain, d’itinéraires, de tuiles cartographiques et de données géographiques hors de cette zone.
- Des lieux enregistrés pour Pointe-à-Pitre, Basse-Terre, Capesterre-Belle-Eau, l’aéroport Pôle Caraïbes, Saint-François, Deshaies, Grand-Bourg, Terre-de-Haut et La Désirade.
- En Guadeloupe, les bâtiments utilisent les emprises IGN BD TOPO, avec les hauteurs, étages et matériaux disponibles. Les altitudes et largeurs de chaussée IGN sont utilisées quand elles existent et correspondent aux segments générés. Les cellules téléchargées restent disponibles hors ligne ; Overture sert de secours pour les bâtiments si l’IGN ne répond pas au premier téléchargement.
- Au sol, les photos aériennes IGN BD ORTHO de Guadeloupe remplacent les images satellite moins détaillées lorsqu’elles sont disponibles. Elles sont téléchargées à la demande et conservées dans le cache hors ligne.
- Une carte centrée sur la Guadeloupe, affichant par défaut les routes et les noms de lieux. Son zoom s’arrête à la résolution native des couches cartographiques pour éviter les agrandissements flous ; la carte montre aussi les îles et la mer autour de la zone de conduite.
- Les emprises de bâtiments ordinaires qui croisent une route sont écartées pour éviter de bloquer la chaussée ; les ponts reconnus, les canopies étroites et les portails de tunnel gardent leur traitement dédié.
- Des caches locaux pour les téléchargements, le relief, les données cartographiques et les tuiles générées.
- Les vérifications de mises à jour amont et l’ancien annuaire public BeamNG.Earth sont désactivés.

## Langue et connexion

Les menus, réglages, carte, page d’accueil, barre d’état et messages principaux du mod s’affichent en français. La langue du jeu n’a pas besoin d’être modifiée.

Dans **Pause → Mods → Guadeloupe Earth → Monde**, le réglage **Connexion Internet** propose trois boutons :

- **Automatique** : utilise Internet lorsque la connexion est disponible et revient aux données déjà en cache si elle ne l’est pas.
- **En ligne** : autorise le téléchargement des données manquantes. Si la connexion est indisponible, le mod continue avec les données en cache lorsque c’est possible.
- **Hors ligne** : bloque les nouvelles requêtes Internet et utilise uniquement les données déjà téléchargées.

Le réglage est conservé entre les sessions. En mode hors ligne, les zones jamais téléchargées peuvent rester vides ou incomplètes. Le cache ne précharge pas automatiquement tout l’archipel.

## Limite géographique

Les limites actuelles (`15.75..16.60 N`, `-61.95..-60.90 W`) forment un rectangle de travail, et non une frontière côtière ou administrative officielle. Elles incluent la mer entre les îles et des zones au large. Les coordonnées de départ sont indicatives et n’ont pas toutes été alignées sur des voies vérifiées.

## Installation

La procédure Windows est détaillée dans [`INSTALLATION_FR.txt`](INSTALLATION_FR.txt).

## Données et caches hors ligne

Le serveur réutilise les données téléchargées et les tuiles de routes générées entre les sessions. Les caches sur disque n’ont pas de limite logicielle par défaut ; l’espace disque disponible reste la limite pratique. Les caches mémoire restent bornés pour préserver la stabilité. Hors ligne, seules les données déjà présentes sur l’ordinateur sont disponibles.

## Limites de cette préversion

- Cette archive ne contient pas de mosaïque d’orthophotos préinstallée, de masque côtier ni de jeu complet de routes et de végétation. Les photos IGN et les bâtiments IGN sont récupérés à la demande ; ils restent en cache ensuite. Le relief détaillé et les routes restent dépendants des jeux de données disponibles.
- Les algorithmes géométriques génériques restent présents, mais les demandes de données sont limitées par la zone Guadeloupe.
- La validation en jeu, le test du moteur Lua, le multijoueur BeamMP et les performances restent à confirmer.
- Les neuf lieux nommés sont des destinations dynamiques. Le niveau contient un seul objet physique `SpawnSphere` ; les autres entrées déclenchent des téléportations vers des lieux enregistrés.

Consultez [`GUADELOUPE_EARTH_PREVIEW.md`](GUADELOUPE_EARTH_PREVIEW.md) pour les notes de migration et les travaux restants. Pour diagnostiquer les ralentissements, utilisez `run_server_diagnostics.bat`, qui écrit `Guadeloupe-Earth-diagnostic.log` sur le Bureau.
