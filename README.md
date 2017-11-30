# Image Debian Wan Party 
## iso
pour générer les images utiliser simplement la commande : 

```
make all
```

Les images se trouvent dans le répertoire ``build/images``


## Prerequis d'installation :
* La machine doit posséder 2 cartes réseaux
* La carte reconnue comme `eth0` sera l'interface extérieure
* La carte reconnue comme `eth1` sera celle coté joueurs
* le disque dur est completement repartitionné et effacé

si après install, les cartes ne sont pas les bonnes, refaire l'install en permutant les branchements, c'est plus simple et fiable. sinon le repertoire `/etc/udev/rules.d` contient un fichier template qui permet de forcer les noms des interfaces. 

## Installation :
L'installtion est complètement automatique, sauf une question pour renseigner le numéro de votre département et une autre pour le proxy si vous en avez besoin. Sinon vous pouvez laisser le champ vide.

La machine installée a `r00tme` comme mot de passe par défaut pour l'utilisateur `root` **A CHANGER !!!!! TOUT DE SUITE**
