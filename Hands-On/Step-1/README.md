Step 1 : La ligne de commande
============================================================

> **Objectif :** Appréhender l'utilisation du vocabulaire de l'écosystème Docker ainsi que les principales fonctionnalités du runtime.  

## Quelques ressources utiles

* Docker.io : https://www.docker.com/
* Docker HUB Registry : https://registry.hub.docker.com/
* Docker Reference **Command Line** : http://docs.docker.com/reference/commandline/cli/  


## Les Images

Pour comprendre la notion d'image et de conteneur, nous allons mettre en place un server MySQL.  
Actuellement, aucun serveur MySQL n'est présent sur le serveur, vous pouvez le vérifier en tentant de vous connecter :

```sh
$> mysql -u root -h 127.0.0.1 -p
```

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

## Les Conteneurs

#### Utiliser les conteneurs.

* Vérifier que votre conteneur `mysql-db` est lancé avec la commande : `sudo docker ps` (l'option `-a` vous permet de voir aussi ceux qui ne sont pas démarré)
* Afficher les logs du conteneur : `sudo docker logs mysql-db` (--follow permet de faire persister l'affichage)
* Vérifier que le conteneur utilise bien les processus du serveur (contrairement à une VM ) : `sudo ps -aux`
* Vérifier que le conteneur, en revanche, ne voit que ses propres processus : `sudo docker exec -it mysql-db ps -aux`
* Examiner la configuration du conteneur : `sudo docker inspect mysql-db`

#### Altérer l'état d'un conteneur
 Afin de montrer que la modification d'un conteneur n'influe pas sur l'image, nous allons apporter un changement à la base MySQL :  

* Se connecter au serveur : `mysql -u root -h 127.0.0.1 -p`
* Utiliser la base "mysql" : `mysql> use mysql;`
* Lister les tables : `mysql> show tables;`
* Supprimer la table USER : `mysql> drop table USER;`
* Se déconnecter : `mysql> exit;`

#### Récréer un conteneur

Avec les informations listées ci-dessus et l'aide en ligne :
* Créer un conteneur `mysql-db2` (attention au port)
* Se connecter au serveur MYSQL
* Vérifier que la table USER existe toujours.

> **Next Step :** Step-2
