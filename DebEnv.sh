#!/bin/bash
echo "##################################################
Script d'installation de l'environnement Debian Essential
Dernière Mise à jour: 20/04/2023 par Jörgen
##################################################"

# Confirmation d'exécution
read -p "Voulez-vous exécuter ce script ? (y/n) " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "OK."
else
    echo "[INFO] Fin de l'exécution."
    exit 0
fi

# Vérifier que le script est exécuté en tant que root
if [[ $EUID -ne 0 ]]; then
   echo "[ERREUR] Ce script doit être exécuté en tant que root" 
   exit 1
fi

# Mise à jour des paquets
echo "[INFO] Mise à jour des paquets"
apt-get update
apt-get upgrade -y

# Installlation
read -p "Voulez-vous installer Sudo ainsi que l'environnement VSCode ? (y/n) " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    f_sudo
else
    echo "[INFO] Fin de l'exécution."
    exit 0
fi

####################################
# FONCTIONS
####################################
function f_sudo()
{
   # Création de l'utilisateur VSCode
   VS_USER="vscode"
   useradd -m $VS_USER
   echo "Mot de passe pour l'utilisateur $VS_USER :"
   passwd $VS_USER

   # Installation de SUDO + VSCode sudoers
   apt-get install -y sudo
   usermod -aG sudo $VS_USER
   echo "$VS_USER ALL=(ALL) ALL" >> /etc/sudoers
}