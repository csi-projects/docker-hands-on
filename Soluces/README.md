TP Docker

Timing :
-	30min: intro DevOps : contraintes, pourquoi ?
-	1h: Cours magistral - qu'est-ce que Docker ? - faire passer la clé USB
-	2h: TP mise en pratique
o	30min + 15min + 1h15

=> Définir des temps intermédiaires / paliers pour mettre tout le monde à niveau
=> Pour chaque étape, on doit avoir un répertoire "solution"

==========

Support :
Box vagrant : ubuntu
- curl
- client mysql
- git
- docker
- mettre dans la box vagrant les tar.gz

==========

Step 0 (20-30 min) : install de l'environnement
=> Installation
- install de virtualbox + vagrant
- fournir la box vagrant
- ajouter la box vagrant
- lancer la box vagrant

===========

Step 1 (15min en Live Démo) : Découverte de Docker : voir la différence entre conteneur et image
=> Base mysql
- utiliser une image mysql
  - aller sur le hub registry
  - prendre l'image officielle
  - démarre le conteneur en exposant le port mysql
- show table
- remove table
- show table -> ma table a été supprimée

==========

Step 2 : Déploiement d’une stack : Java + Tomcat / MySQL
Limiter les accès réseau à l'aide de ZIPs ou d'images déjà prêtes dans une VM vagrant existante
Utiliser l'application générée avec tolosys tools : Spring MVC + Spring Data JPA

Java :
- utiliser l’application d'exemple de telosys tools
MySQL :
- avoir un fichier SQL d'initialisation de la base avec des données
- donner aux élèves la commande pour initialiser la base pour l'ajouter au Dockerfile pour que la base soit initialisée au moment du build


Vagrant
- contient Docker
- contient l'image Docker de base de MySQL
- ZIP : Java + Tomcat + War de l'appli + SQL d'initialisation

Image de base de MySQL
- MySQL (image officielle)
Image de base de Maven + Java + Tomcat
- ubuntu

Création de l'image MySQL
- utiliser l'image de base
- indiquer que les données de la base sont dans un volume
- EXPOSE port mysql

Création de l'image Tomcat
- utiliser le .tar.gz de Tomcat et Java
  - ADD du .tar
  - le dézipper
- install Tomcat Java + conf environnement
  - mettre les variables d'env : JAVA_HOME
- le WAR de l'application est inclu dans l'image pour que tout soit prêt au démarrage du conteneur
  - ADD du .war
- la log du tomcat est situé sur un volume
- EXPOSE 8080

Démarrage du conteneur MySQL
- initialiser la base de MySQL à la création de l'image avec le fichier SQL
- faire un commit pour faire une nouvelle image MySQL avec la base initialisée
- démarrer un conteneur sur cette nouvelle image

Démarrage du conteneur Tomcat
- lier les deux conteneurs soit via le nom défini dans le /etc/hosts
- exposer en public le port 8080

Résultat
-	Aller sur la page de l'application
-	aller sur un formulaire
-	vérifier que les données de la base sont visibles et modifiables
