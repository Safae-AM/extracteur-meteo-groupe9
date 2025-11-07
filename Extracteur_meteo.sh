#!/bin/bash

ville="Paris"
if [ -n "$1" ]; then
	ville="$1"
fi

fichier_brut="meteo_brut.txt"

curl -s "wttr.in/${ville}?format=j1" >"$fichier_brut"

if [ ! -s "$fichier_brut" ]; then
        echo "erreur: Pas possible de récupérer les données météo pour la ville marquée"
        exit 1
fi

temp_actuelle=$(grep -m1 '"temp_C"' "$fichier_brut" | sed 's/[^0-9\-]//g')
temp_demain=$(grep -m1 '"avgtempC"' "$fichier_brut" | sed 's/[^0-9\-]//g')

date_actuelle=$(date +"%Y-%m-%d")
heure_actuelle=$(date +"%H:%M")

echo "${date_actuelle} - ${heure_actuelle} - ${ville} : ${temp_actuelle}°C - ${temp_demain}°C" >>meteo.txt

echo "météo enregistrée dans meteo.txt"

