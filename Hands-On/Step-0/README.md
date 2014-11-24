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

### 3- Importation des serveurs

L'ensemble des VM utilisées pour le TP sous disponible sous `/Servers/`

- Afin d'importer les VM lancer les commandes suivantes :

>- **Windows** :
```sh
import_servers.bat
```

> - **Linux / MacOs** :
```sh
chmod +x import_servers.sh
./import_servers.sh
```

- Vérifier que les servers ont bien été importés via la commande :
```sh
vagrant box list
```
Vous devez retrouver l'ensemble des .box dans la liste.

### 4- Lancer le serveur principal

- Se rendre sous : `/Hands-On/Servers/Docker-Practice/`
- Démarrer le serveur via la commande `vagrant up`
- Se connecter en ssh au serveur via la commande : `vagrant ssh`


> **Next Step :** Step-1
