# Image Debian Wan Party 

## Prerequis d'installation :
* La machine doit posséder 2 cartes réseaux
* La carte reconnue comme `eth0` sera l'interface extérieure
* La carte reconnue comme `eth1` sera celle coté joueurs
* le disque dur est completement repartitionné et effacé

si après install, les cartes ne sont pas les bonnes, refaire l'install en permutant les branchements, c'est plus simple et fiable. sinon le repertoire `/etc/udev/rules.d` contient un fichier [template](https://github.com/wanrt/wanparty-network-config/blob/master/usr/share/wanparty/etc/udev/rules.d/70-persistent-net.rules.template) qui permet de forcer les noms des interfaces. 

## Installation :
L'installtion est complètement automatique, sauf une question pour renseigner le numéro de votre département et une autre pour le proxy si vous en avez besoin. Sinon vous pouvez laisser le champ vide.

La machine installée a `r00tme` comme mot de passe par défaut pour l'utilisateur `root` **A CHANGER !!!!! TOUT DE SUITE**

Afin de vérifier si tous les services tournent normalement, taper la commande : `systemctl list-units --state=failed`. Une interface réseau vpn `tun0` doit aussi être présente. 

## Fonctionnement 
L'iso fait appel à un dépôt debian signé et créé spécialement avec les paquets qui contiennent les différentes configurations nécessaires. 

Les sources pour générer un tel dépôt sont sur : [wanrt/repository](https://github.com/wanrt/repository).

### liste des packets 
- [wanparty-localserver](https://github.com/wanrt/wanparty-localserver) : Paquet meta pour installer le nécessaire. 
- [wanparty-base](https://github.com/wanrt/wanparty-base) : Paquet de base pour sauvegarder le numéro du département.
- [wanparty-dns-server](https://github.com/wanrt/wanparty-dns-server) :  la configuration du serveur dns.
- [wanparty-ldap](https://github.com/wanrt/wanparty-ldap) : la configuration client ldap pour l'authentification des joueurs.
- [wanparty-network-config](https://github.com/wanrt/wanparty-network-config) : la configuration réseau des deux interfaces `eth0` et `eth1` avec leurs règles QoS.
- [wanparty-vpn-client](https://github.com/wanrt/wanparty-vpn-client) : les configurations client openvpn, les sources sont en privé car contiennent les clés de connexion. Le réseau vpn est nécessaire pour sécuriser et privatiser la connexion au server ldap et la communication facile entre routeurs. 
- [wanparty-dhcp-server](https://github.com/wanrt/wanparty-dhcp-server) : configuration du serveur dhcp sur l'interface `eth1`.
- [wanparty-firewall](https://github.com/wanrt/wanparty-firewall) : les règles pare-feu utilisant shorewall. 
- [wanparty-portal](https://github.com/wanrt/wanparty-portal) : le portail captif et les commandes de gestion des clients.
- [wanparty-supervision](https://github.com/wanrt/wanparty-supervision) : le plugin de ntopng pour assurer une connextion entre les données ntopng et le portail/outils de supervision. 

### liste des commandes
- `wanparty-add-machine <ip> <user> <role>` / où role est soit USER ou ORGA : Une commande pour autoriser une machine à utiliser le réseau (ajout sur la base de données et les règles pare-feu associées). Seuls les utilisateurs avec le rôle ORGA peuvent voir les outils de supervision sur le portail captif. 
- `wanparty-delete-machine <ip>` : supprimer une machine du réseau. 
- `wanparty-list-machines` : affiche une liste des machines autorisées.
- `wanparty-ban-machine <ip>` : bannir une machine. 
- `wanparty-unban-machine <ip>` : débannir une machine.
- `wanparty-ntop` : affiche le trafic réseau actuel par machine. Le mieux est de l'utiliser avec la commande : `watch wanparty-ntop`.


### fichiers logs 
tous les fichiers logs sont sur `/var/log/wanparty/`.


## création de l'iso (développeurs)
pour générer les images utiliser simplement la commande : 

```
make all
```

Les images se trouvent dans le répertoire ``build/images``

