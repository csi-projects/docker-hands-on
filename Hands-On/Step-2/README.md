Step 2 : Déploiement d'une application Java (Tomcat/MySQL)
=============================================================

> **Objectif :** Appréhender l'utilisation des Dockerfile via la "conteneurisation" d'une application Java (Tomcat et MySQL) et la déployer sur un serveur.

## Quelques ressources utiles

* Docker Reference **Command Line** : http://docs.docker.com/reference/commandline/cli/
* Docker Reference **Dockerfile** : http://docs.docker.com/reference/builder/


## 1- La base de données

Nous allons démarrer la base de données. Pour cela, nous utilisons l'image officielle `mysql` de Docker et nous utilisons le client `mysql` de la machine hôte pour initialiser la base à partir d'un script SQL.

### 1.1- Démarrer la base de données

Utiliser la commande de lancement de conteneur `docker run` à partir de l'image `mysql` en indiquant :
* le conteneur sera lancé en tâche de fond (démon)
* le nom du conteneur `myapp-db`
* le port `3306` doit être mappé sur le port `3306` de la machine hôte
* les variables d'environnement doivent être définies :
  * `MYSQL_ROOT_PASSWORD=password`
  * `MYSQL_USER=handson`
  * `MYSQL_PASSWORD=handson`
  * `MYSQL_DATABASE=handson`

#### Vérification
Vérifier que le conteneur est démarré via `docker ps`.

Si le conteneur n'est pas visible via `docker ps`, essayez alors avec `docker ps -a` qui affiche les conteneurs démarrés et arrêtés. En effet, en cas d'erreur, le conteneur est arrêté aussitôt.

La commande `docker logs [nom du conteneur]` affiche la sortie console dans le conteneur qu'il n'y a pas eu d'erreur au démarrage.

En cas d'erreur, il est possible de supprimer le conteneur en l'arrêtant via `docker stop [nom du conteneur]` puis en le supprimant via `docker rm [nom du conteneur]`. Il est alors possible de relancer un nouveau conteneur via `docker run`.

### 1.2- Créer les tables et les données

Nous créons les tables et les données de la base via le script SQL :
* Aller dans le répertoire `/home/vagrant/mysql`
* Lancer la commande : `mysql -h"127.0.0.1" -P"3306" -u"handson" -p"handson" < mysql/mysql-create-database.sql`

Vérifier que les données ont bien été créées :
* Lancer la commande : `mysql -h"127.0.0.1" -P"3306" -u"handson" -p"handson"`
* une fois connecté sur mysql, lancer : `select * from handson.city;` (sans oublier ";")
* vous devez voir la table `city` des données :
```
mysql> select * from handson.city;
+----+-----------+-------------------+-----------------------------+---------+
| id | city      | department        | region                      | country |
+----+-----------+-------------------+-----------------------------+---------+
|  1 | Paris     | Paris             | Ile de France               | France  |
|  2 | Nantes    | Loire-Atlantique  | Pays de la Loire            | France  |
|  3 | Rennes    | Ille-et-Vilaine   | Bretagne                    | France  |
|  4 | Marseille | Bouches-du-Rhône  | Provence-Alpes-Côte d'Azur  | France  |
|  5 | Lyon      | Rhône             | Rhône-Alpes                 | France  |
|  6 | Bordeaux  | Gironde           | Aquitaine                   | France  |
+----+-----------+-------------------+-----------------------------+---------+
```

## 2- Le serveur d'applications

### 2.1- Image du serveur d'applications

Nous allons maintenant créer l'image et le conteneur Docker pour le serveur d'application Java/Tomcat.

*Note: pour des raisons d'accès réseau, l'installation de Java et Tomcat s'effectue via des fichiers compressés.*

Nous allons créer et démarrer la base de données dans un conteneur via Docker. Pour cela, nous allons créer le fichier **Dockerfile** :
* En ligne de commandes, placez-vous dans le répertoire **/home/vagrant**
* Créer le fichier **Dockerfile** via la commande `nano tomcat/Dockerfile`

Avec l'aide de la documentation en ligne sur la création d'un ficher Dockerfile et des examples dans le support de présentation, nous créons une image pour le serveur d'application qui répond à la description suivante :
* L'image doit se baser sur l'image **ubuntu 14.04**
* Présence de **Java en version 1.7.0_71** (Installer le JDK 1.7 en utilisant l'archive `tomcat/jdk-7u71-linux-x64.gz` fournie)
  * Notes : le fichier **jdk-7u71-linux-x64.gz** une fois décompressé crée le répertoire **jdk1.7.0_71**
* Présence de **Tomcat en version 7.0.57 ** (Utiliser l'archive `tomcat/apache-tomcat-7.0.57.tar.gz` fournie)
  * Note : le fichier **apache-tomcat-7.0.57** une fois décompressé crée le répertoire **apache-tomcat-7.0.57**
* La variable d'environnement **JAVA_HOME** est correctement renseignée
* L'application `handson` doit être déployée (Utiliser l'archive `tomcat/handson.war` fournie)
* Le conteneur doit démarrer le serveur Tomcat.
  * Note : pour démarrer Tomcat, exécuter `catalina.sh run` du répertoire `apache-tomcat-7.0.57/bin``

Une fois le fichier **Dockerfile** complété, construire l'image via la commande `docker build` en spécifiant le tag `handson/myapp-server`.

Vérifier que l'image a bien été créée via la commande `docker images`.

### 2.2- Démarrage du conteneur du serveur d'applications

Nous démarrons le conteneur du serveur d'applications en le liant lié au conteneur de la base de données que nous avons démarré précédemment.

Démarrer le conteneur à partir de l'image `handson/myapp-server` avec :
 * le nom d'image `myapp-server`
 * l'application est accessible sur le **port 8081**
 * le conteneur de cette image doit être lié au conteneur de l'image `handson/myapp-db` créée via l'étape précédente. Le nom de ce lien doit être **mysql** dans le conteneur `myapp-server`

#### Vérification
Vérifier que le conteneur a bien été démarré via la commande `docker ps`.

Si le conteneur n'est pas visible via `docker ps`, essayez alors avec `docker ps -a` qui affiche les conteneurs démarrés et arrêtés. En effet, en cas d'erreur, le conteneur démarré est arrêté aussitôt.

La commande `docker logs [nom du conteneur]` affiche la sortie console dans le conteneur ce qui permet de vérifier que le serveur Tomcat est bien démarré et qu'il n'y a pas eu d'erreur au démarrage.

#### En cas d'erreur
Il est possible de supprimer le conteneur en l'arrêtant via `docker stop [nom du conteneur]` puis `docker rm [nom du conteneur]`.

Si l'erreur provient du fichier **Dockerfile**, nous avons alors à supprimer le conteneur, à corriger ce fichier **Dockerfile**, à recontruire l'image via `docker build` puis à redémarrer le conteneur via `docker run`.

## 4- L'accès à l'application

* Accéder à l'application : http://192.168.29.100:8081/
* Vérifier que l'application est fonctionnelle en modifiant les données.

## 5- Scalabilité de l'application

* Lancer une deuxième instance du serveur Tomcat, écoutant sur le port **8082**
* Accéder à l'application : http://192.168.29.100:8082/
* Vérifier que l'application est fonctionnelle en modifiant les données.

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
