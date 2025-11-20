#!/bin/bash

ville="Paris"
if [ -n "$1" ]; then
    ville="$1"
fi

fichier_brut="meteo_brut.txt"
fichier_meteo="meteo_$(date +%Y%m%d).txt"

# Récupération JSON wttr.in
curl -s "wttr.in/${ville}?format=j1" > "$fichier_brut"

# Vérification
if [ ! -s "$fichier_brut" ]; then
    echo "erreur: Pas possible de récupérer les données météo pour la ville marquée"
    exit 1
fi

# EXTRACTIONS

# Température actuelle
temp_actuelle=$(grep -m1 '"temp_C"' "$fichier_brut" | sed 's/[^0-9\-]//g')

# Température moyenne demain
temp_demain=$(grep -m1 '"avgtempC"' "$fichier_brut" | sed 's/[^0-9\-]//g')

# Vent (windspeedKmph)
vent=$(grep -m1 '"windspeedKmph"' "$fichier_brut" | sed 's/[^0-9]//g')
if [ -n "$vent" ]; then
    vent="${vent} km/h"
else
    vent="N/A"
fi

# Humidité (humidity)
humidite=$(grep -m1 '"humidity"' "$fichier_brut" | sed 's/[^0-9]//g')
if [ -n "$humidite" ]; then
    humidite="${humidite}%"
else
    humidite="N/A"
fi

# Visibilité (visibility)
visibilite=$(grep -m1 '"visibility"' "$fichier_brut" | sed 's/[^0-9]//g')
if [ -n "$visibilite" ]; then
    visibilite="${visibilite} km"
else
    visibilite="N/A"
fi

# HORODATAGE

date_actuelle=$(date +"%Y-%m-%d")
heure_actuelle=$(date +"%H:%M")

# ÉCRITURE VERSION 1 + VARIANTE 1

echo "${date_actuelle} - ${heure_actuelle} - ${ville} : ${temp_actuelle}°C - ${temp_demain}°C - Vent: ${vent} - Humidité: ${humidite} - Visibilité: ${visibilite}" >> "$fichier_meteo"

echo "météo enregistrée dans $fichier_meteo"
