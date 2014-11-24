Base Server : Construction de la VM de Base pour le hands-on
=============================================================

### Mettre à disposition la box pour les participants :
1. `vagrant up` : l'ensemble des installations sont réalisées via le script `provision.sh`
2. `vagrant package --output docker-handson.box` : création du fichier box à copier sur une clé USD
3. `vagrant box add docker-handson docker_handson.box` : ajout du fichier box dans vagrant
