Step 2 : Déploiement d'une application Java (Tomcat/MySQL)
=============================================================

> **Objectif :** Appréhender l'utilisation des Dockerfile via la "conteneurisation" d'une application Java (Tomcat et MySQL) et la déployer sur un serveur.

## Quelques ressources utiles

* Docker Reference **Command Line** : http://docs.docker.com/reference/commandline/cli/
* Docker Reference **Dockerfile** : http://docs.docker.com/reference/builder/


## 1- La base de données

Avec l'aide de la documentation en ligne sur la création d'un ficher Dockerfile et des examples dans le support de présentation, créer une image pour le serveur de base de données répondant à la description suivante :
* L'image doit se baser sur l'image **mysql en version 5.7**
* La base de données est créée avec le script `files/mysql/mysql-create-database.sql`
* Les dossiers suivant doivent-être persistés : "/etc/mysql" et "/var/lib/mysql"
* Respecter le nom de l'image suivant : `emn/myapp-db`


## 2- Le serveur d'application

Avec l'aide de la documentation en ligne sur la création d'un ficher Dockerfile et des examples dans le support de présentation, créer une image pour le serveur d'application répondant à la description suivante :
* L'image doit se baser sur l'image **ubuntu 14.04**
* Présence de **Java en version 1.7.0_71** (Installer le JDK 1.7 en utilisant l'archive `files/tomcat/jdk-7u71-linux-x64.gz` fournie)
* Présence de **Tomcat en version 7.0.57 ** (Utiliser l'archive `files/tomcat/apache-tomcat-7.0.57.tar.gz` fournie)
* Les variables d'environnement **JAVA_HOME** et **TOMCAT_HOME** sont correctement renseignées
* L'application handson doit être déployée (Utiliser l'archive `files/tomcat/handson.war` fournie)
* Les conteneurs doivent démarrer le serveur Tomcat.
* Respecter le nom de l'image suivant : `emn/myapp-server`


## 3- Le déploiement

Déployer l'application myapp sur le serveur :
* Lancer un conteneur de l'image `myapp-db`
* Lancer un conteneur de l'image `myapp-server`
 * Les logs de Tomcat sont disponibles, **sur le serveur** host sous `~/myapp/tomcat/logs`
 * L'application est accessible sur le **port 8081**
 * Le conteneur de cette image doit être lié au conteneur de  'image `emn/myapp-db` créée via l'étape précédente. **Nommer ce lien "mysql"**


## 4- L'accès à l'application

* Accéder à l'application : http://192.168.29.100:8081/
* Vérifier que l'application soit fonctionnelle en modifiant les données.

## 5- Scalabilité de l'application

* Lancer une deuxième instance du serveur Tomcat, écoutant sur le port **8082**
* Accéder à l'application : http://192.168.29.100:8082/
* Vérifier que l'application soit fonctionnelle en modifiant les données.


## 6- Mettre en place un reverse proxy

Maintenant que nous avons 2 serveurs Tomcat, nous allons mettre en oeuvre un reverse proxy afin d'offir un point d'accès unique à notre application (sur le port 80).

Le reverse proxy sera configuré pour faire du load-balancing (round-robin) sur nos 2 serveurs Tomcat.

Nous allons utiliser HAProxy pour cela. Une image a déjà été chargée sur le serveur : `dockerfile/haproxy`  
Voir : https://registry.hub.docker.com/u/dockerfile/haproxy/  

Pour vous faciliter la configuration, le fichier haproxy.cfg est disponible sous `/home/vagrant/proxy/` du serveur.

Les dernières lignes sont importantes :
```
listen session-webapp :80 (1)
    balance roundrobin (2)
    server tomcat1 t1:8080 check (3)
    server tomcat2 t2:8080 check (4)
    stats enable (5)
    stats uri /stats
```
>(1) Le proxy écoute sur le port 80  
>(2) Le load-balancer utilise round-robin  
>(3) Redirection vers le premier serveur (nom du host t1)  
>(4) Redirection vers le second serveur (nom du host t2)  
>(5) Le service de stats de HAProxy est disponible via l'url `/stats`  

**Etapes :**  
* Avec la documentation de l'image (https://registry.hub.docker.com/u/dockerfile/haproxy/)
* Démarrer un conteneur en respectant les règles suivantes :
 * Le conteneur doit se nommer `proxy`
 * Le port 80 doit être mappé avec celui du serveur  
 * La configuration de base doit être surchargée (*voir haproxy-override dans la doc de l'image*)
 * Le conteneur doit être lié au premier conteneur tomcat créé plus haut (le lien doit se nommer *t1* * voir haproxy.cfg)
 * Le conteneur doit être lié au second conteneur tomcat créé plus haut (le lien doit se nommer *t2* * voir haproxy.cfg)

**Vérification :**
* Accéder à l'application : http://192.168.29.100/
* Accéder plusieurs fois (F5) à l'application
* Vérifier la répartition de la charge : http://192.168.29.100/stats
* Arrêter un des deux conteneurs Tomcat (suco docker stop {nom} )
* Vérifier que l'application est toujours fonctionnelle : http://192.168.29.100/
* Regarder de nouveau les stats de HAProxy :   http://192.168.29.100/stats
