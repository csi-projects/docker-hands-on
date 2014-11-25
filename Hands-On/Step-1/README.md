Step 1 : La ligne de commande
============================================================

> **Objectif :** Appréhender l'utilisation du vocabulaire de l'écosystème Docker ainsi que les principales fonctionnalités du runtime.  

## Quelques ressources utiles

* Docker.io : https://www.docker.com/
* Docker HUB Registry : https://registry.hub.docker.com/
* Docker Reference **Command Line** : http://docs.docker.com/reference/commandline/cli/  


## 1- Les Images

Pour comprendre la notion d'image et de conteneur, nous allons mettre en place un serveur MySQL.  
Actuellement, aucun serveur MySQL n'est présent sur la VM , vous pouvez le vérifier en tentant de vous connecter :

```sh
$> mysql -u root -h 127.0.0.1 -p
```
*(peu importe le password pour le moment)*  

Le message d'erreur met en évidence l'absence de serveur.

#### Utiliser le HUB Docker

* Accéder au Registry HUB de Docker  : https://registry.hub.docker.com/
* Rechercher l'image officielle de **Mysql**
* Repérer la commande `docker pull` vous permettant de télécharger l'image.
* Repérer les exemples de commandes pour démarrer une instance du serveur.


#### Démarrer une instance de MySQL

En utilisant la documentation de l'image officielle, démarrer un serveur MySQL en suivant les règles suivantes :
* Le container doit se nommer mysql-db
* Le port 3306 du conteneur doit être mappé avec le port 3306 du serveur
* Le mot de passe pour l'utilisateur `root` doit être `admin`

>**Exemple de commande :**  
>`sudo docker run -d --name {nom_conteneur} -p {host_port:host_conteneur} {nom_image}`

## 2 - Les Conteneurs

#### Utiliser les conteneurs.

* Vérifier que votre conteneur `mysql-db` est lancé avec la commande : `sudo docker ps` (l'option `-a` vous permet de voir aussi ceux qui ne sont pas démarrés)
* Afficher les logs du conteneur : `sudo docker logs mysql-db` (--follow permet de faire persister l'affichage)
* Vérifier que le conteneur utilise bien les processus du serveur (contrairement à une VM ) : `sudo ps -aux`*(repérer mysqld)*
* Examiner la configuration du conteneur : `sudo docker inspect mysql-db`

#### Altérer l'état d'un conteneur
 Afin de montrer que la modification d'un conteneur n'influe pas sur l'image, nous allons apporter un changement à la base MySQL :  

* Se connecter au serveur : `mysql -u root -h 127.0.0.1 -p`
* Utiliser la base "mysql" : `mysql> use mysql;`
* Lister les tables : `mysql> show tables;`
* Supprimer la table USER : `mysql> drop table user;`
* Se déconnecter : `mysql> exit;`

#### Récréer un conteneur

Avec les informations listées ci-dessus et l'aide en ligne :
* Créer un conteneur `mysql-db2` (**sur le port 3307 du host cette fois**)  
 * Exemple de commande :  
 `sudo docker run -d --name {nom_conteneur} -p {host_port:host_conteneur} {nom_image}`
* Se connecter au serveur MYSQL : ` mysql -u root -h 127.0.0.1 -P 3307 -p`
* Vérifier que la table USER existe dans ce conteneur.  

#### Arret et suppression des conteneurs
* Lister les conteneurs en cours d'exécution : `sudo docker ps`
* Arrêter les conteneurs : `sudo docker stop {nom_conteneur1} {nom_conteneur2} `
* Supprimer les conteneurs : `sudo docker rm {nom_conteneur1} {nom_conteneur2}`


> **Next Step :**  [Step-2](https://github.com/csi-projects/docker-hands-on/tree/master/Hands-On/Step-2)
