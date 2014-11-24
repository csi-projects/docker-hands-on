Step 0 : Installation de l'environnement
============================================================  
> **Objectif :** Installation des outils permettant la mise en oeuvre du TD.  

### 1- Installation de VirtualBox
#### Installation
Les sources d'installation sont disponibles sur le support USB sous :  
`/Installs/{OS}/VirtualBox/`

> **Note:** La version **pour Linux** est compatible pour toutes les distributions. Choisir le répertoire 32 ou 64 en fonction de l'OS.  
Pour installer le package :  
```sh
$> chmod +x VirtualBox-4.3.18-96516-Linux_{xx}.run
$> ./VirtualBox-4.3.18-96516-Linux_{xx}.run
```  

### 2- Installation de Vagrant

Les sources d'installation sont disponibles sur le support USB sous :  
`/Installs/{OS}/Vagrant/`

> **Note:** Pour la version **Linux**, choisir le répertoire 32 ou 64 en fonction de l'OS.  
Pour installer le package :  
> - **Debian** :
```
dpkg -i vagrant_1.6.5_{xx}.deb
```
> - **RedHat** :
```
rpm -i vagrant_1.6.5_{xx}.rpm
```

### 3- Importation du serveur

La VM utilisée pour le TP est disponible sous `/Servers/Docker-Pactice`

- Afin d'importer la VM lancer la commande suivante :  
```sh
vagrant box add docker_handson docker_handson.box
```


- Vérifier que le server a bien été importé via la commande :
```sh
vagrant box list
```
Vous devez retrouver une entrée pour `docker_handson`.

### 4- Lancer le serveur principal

- Toujours sous : `/Hands-On/Servers/Docker-Practice/`
- Démarrer le serveur via la commande `vagrant up`
- Se connecter en ssh au serveur via la commande : `vagrant ssh`


> **Next Step :** [Step-1](https://github.com/csi-projects/docker-hands-on/tree/master/Hands-On/Step-1)
