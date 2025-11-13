# extracteur-meteo-groupe9


Configuration du cron : 
- Création d'un workflows sur GitHub sur la branche main
- Mise en référence de la branche Version-2-automatisation-periodique
- Utilisation de cron pour l'execution automatique toutes les 5 minutes
- Garde les identifiants GitHub du membre du groupe pour le commit et le push
- Rajout des droits d'execution sur le script Extracteur_meteo.sh
- Rajout des droits d'ecriture sur le fichier meteo.txt
- S'authentifie, commit et push le script Extracteur_meteo.sh
- Vérification de la présence et de la mise à jour du fichier meteo.txt 
  dans le répertoire du projet

Tentative de configuration avec wsl mais non compatible au travail de groupe :
- Nécessité de maintenir une arborescence
  locale de fichiers spécifique à chaque utilisateur
- probleme d'authentification avec github 
- impossible de commit/push sur GitHub 
