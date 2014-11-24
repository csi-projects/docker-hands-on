Step 2 : Déploiement d'une application Java (Tomact/MySQL)
=============================================================

> **Objectif :** Appréhender l'utilisation des Dockerfile via la "conteneurisation" d'une application Java (Tomcat et MySQL) et la déployer sur un serveur.

## Quelques ressources utiles

* Docker Reference **Command Line** : http://docs.docker.com/reference/commandline/cli/
* Docker Reference **Dockerfile** : http://docs.docker.com/reference/builder/


## La base de données

Avec l'aide de la documentation en ligne sur la création d'un ficher Dockerfile et des examples dans le support de présentation, créer une image pour le serveur de base de données répondant à la description suivante :
* L'image doit se baser sur l'image **mysql en version 5.7**
* La base de données est créée avec le script `files/mysql/mysql-create-database.sql`
* Les dossiers suivant doivent-être persistés : "/etc/mysql" et "/var/lib/mysql"
* Respecter le nom de l'image suivant : `emn/myapp-db`


## Le serveur d'application

Avec l'aide de la documentation en ligne sur la création d'un ficher Dockerfile et des examples dans le support de présentation, créer une image pour le serveur d'application répondant à la description suivante :
* L'image doit se baser sur l'image **ubuntu 14.04**
* Présence de **Java en version 1.7.0_71** (Installer le JDK 1.7 en utilisant l'archive `files/tomcat/jdk-7u71-linux-x64.gz` fournie)
* Présence de **Tomcat en version 7.0.57 ** (Utiliser l'archive `files/tomcat/apache-tomcat-7.0.57.tar.gz` fournie)
* Les variables d'environnement **JAVA_HOME** et **TOMCAT_HOME** sont correctement renseignées
* L'application handson doit être déployée (Utiliser l'archive `files/tomcat/handson.war` fournie)
* Les conteneurs doivent démarrer le serveur Tomcat.
* Respecter le nom de l'image suivant : `emn/myapp-server`


## Le déploiement

Déployer l'application myapp sur le serveur :
* Lancer un conteneur de l'image `myapp-db`
* Lancer un conteneur de l'image `myapp-server`
>* Les logs de Tomcat sont disponibles, **sur le serveur** host sous `~/myapp/tomcat/logs`
>* L'application est accessible sur le **port 8081**
>* Le conteneur de cette image doit être lié au conteneur de l'image `emn/myapp-db` créée via l'étape précédente. **Nommer ce lien "mysql"**


## L'accès à l'application

* Accéder à l'application : http://192.168.29.100:8081/
* Vérifier que l'application soit fonctionnelle en modifiant les données.

## Scalabilité de l'application

* Lancer une deuxième instance du serveur Tomcat, écoutant sur le port **8082**
* Accéder à l'application : http://192.168.29.100:8082/
* Vérifier que l'application soit fonctionnelle en modifiant les données.


## Mettre en place un reverse proxy

tutum/haproxy
