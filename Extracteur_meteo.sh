#!/bin/bash

ville="Paris"
if [ -n "$1" ]; then
    ville="$1"
fi

# Détection option JSON
json_mode=false
if [[ "$2" == "--json" || "$3" == "--json" ]]; then
    json_mode=true
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

# Vent
vent=$(grep -m1 '"windspeedKmph"' "$fichier_brut" | sed 's/[^0-9]//g')
[ -n "$vent" ] && vent="${vent} km/h" || vent="N/A"

# Humidité
humidite=$(grep -m1 '"humidity"' "$fichier_brut" | sed 's/[^0-9]//g')
[ -n "$humidite" ] && humidite="${humidite}%" || humidite="N/A"

# Visibilité
visibilite=$(grep -m1 '"visibility"' "$fichier_brut" | sed 's/[^0-9]//g')
[ -n "$visibilite" ] && visibilite="${visibilite} km" || visibilite="N/A"

# HORODATAGE

date_actuelle=$(date +"%Y-%m-%d")
heure_actuelle=$(date +"%H:%M")

# ÉCRITURE VERSION 1 + VARIANTE 1

ligne="${date_actuelle} - ${heure_actuelle} - ${ville} : ${temp_actuelle}°C - ${temp_demain}°C - Vent: ${vent} - Humidité: ${humidite} - Visibilité: ${visibilite}"

echo "$ligne" >> "$fichier_meteo"

echo "météo enregistrée dans $fichier_meteo"

# VARIANTE 2 : EXPORT JSON (OPTIONNEL)

if $json_mode; then

    fichier_json="meteo_${date_actuelle}.json"

    cat > "$fichier_json" <<EOF
{
  "date": "$date_actuelle",
  "heure": "$heure_actuelle",
  "ville": "$ville",
  "temperature_actuelle": "${temp_actuelle}°C",
  "temperature_demain": "${temp_demain}°C",
  "vent": "$vent",
  "humidite": "$humidite",
  "visibilite": "$visibilite"
}
EOF

    echo "fichier JSON généré : $fichier_json"
fi
