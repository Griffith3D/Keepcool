#!/bin/bash


## Prompt du nom du KCV ##
echo "Modification du nom de la machine..."
sleep 1 &&
read -p "Saisir le nom du KCV | Ex : GYM-AIO-EGUILLES | : " nom_kcv &&
echo "${nom_kcv}" > /etc/hostname
sed -i 's/borne-proto/'$nom_kcv'/g' /etc/hosts

echo "Fichiers modifiés : /etc/hosts et /etc/hostname" 
sleep 1 &&

## Pour savoir si JACK (PCH) ou DEVICE : alsamixer + F6 ##
read -p "Système de son utilisé ? DAC ou JACK ou DEVICE : " sono &&
if [[ ${sono} = 'JACK' ]]
then sed -i 's/slave.pcm default:DAC/slave.pcm default:PCH/g' /home/keepcool/.asoundrc && sed -i 's/slave.channels 6/slave.channels 2/g' /home/keepcool/.asoundrc
elif [[ ${sono} = 'DEVICE' ]]
then sed -i 's/slave.pcm default:DAC/slave.pcm default:Device/g' /home/keepcool/.asoundrc && sed -i 's/slave.channels 6/slave.channels 2/g' /home/keepcool/.asoundrc
fi

## Modification sources.list ##
echo "Modification sources.list obsolètes et update"
sed -i 's/^deb http:\/\/ftp\.debian\.org\/debian\/ jessie main contrib non-free/#&/' /etc/apt/sources.list
echo "deb http://archive.debian.org/debian wheezy main" | tee -a /etc/apt/sources.list
echo "deb http://archive.debian.org/debian-archive/debian-security/ wheezy updates/main" | tee -a /etc/apt/sources.list
apt-get update
echo "Mise à jour terminée" 
echo "MaJ crontab avec reboot a 5h45" &&
sleep 2 &&

## Crontab ##
crontab -l | { cat; echo "45 5 * * * /sbin/reboot"; } | crontab -

## Téléchargement des cours ##
apt-get install --force-yes -y lftp vim htop &&
echo "Téléchargement des cours..." &&
lftp ftp://clonage:Keepcool2022!@192.168.100.210 -e "mirror -n /FTP/ALL_COURS_KC /usr/share/kcs/cours/ ; quit" &&
mv /usr/share/kcs/cours/ALL_COURS_KC/* /usr/share/kcs/cours/ &&
rm -r /usr/share/kcs/cours/ALL_COURS_KC/ &&
cd /usr/share/kcs/publicite &&
wget -N -b https://distrib-cours.keepcoolpro.fr/Annonce_kcv/33.mp4 &&
cd /usr/share/kcs/professeurs &&
wget -N -b https://distrib-cours.keepcoolpro.fr/NOUVEAUX_COURS_2022/professeurs/{61..67}.png https://distrib-cours.keepcoolpro.fr/NOUVEAUX_COURS_2022/professeurs/{61..67}.photo.png &&
cd /usr/share/kcs/categories &&
wget -N -b https://distrib-cours.keepcoolpro.fr/NOUVEAUX_COURS_2022/categories/32.png 
sleep 2
echo "Téléchargement des cours terminé !"
ls -lsah /usr/share/kcs/cours/*.mp4 &&
sleep 5 &&
rm /root/maj_cours.sh 
rm /root/*.log 

echo "..."
echo "Préparation du KCV terminée"
sleep 1 &&
echo "Redémarrage dans 10 secondes"
sleep 1 &&
echo "Paramétrer la borne dans KCPro et appairer avec le /home/keepcool/client/bin/echange.sh"
echo "Attention si KCV DOMTOM modifier la timezone avec dpkg-reconfigure tzdata et l'heure de reboot du crontab"
sleep 9 && shutdown -r now