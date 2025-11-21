# extracteur-meteo-groupe9

Nous avons d’abord rendu le script capable de s’exécuter même en l’absence d’argument, en définissant “Paris” comme ville par défaut. Par la suite, nous avons effectuer un workflow qui s'occuper d'automatiser le code toute les 5 minutes et nous avons restituer dans le read me la methodologie de la creation d'un workflows.
Grâce à ces améliorations l’utilisateur peut désormais choisir s’il souhaite ou non fournir un argument, lorsqu’une ville est indiquée le script collecte ses données météorologiques de celle ci ou dans le cas contraire il collectera les données de Paris automatiquement .


Methodologie configuration du cron : 
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
