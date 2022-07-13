#!/usr/bin/env bash

LOGFILE="install_log.txt"
OUTILS="outils.txt"
LIB="librairies.txt"
TERMINAL="terminal.txt"
PYTHON="python.txt"
DEV="dev.txt"
RZO="rzo.txt"
FORENSIC="forensic.txt"
I3="theme.txt"

PLUS="\033[1;32m+\033[0m"
MOINS="\033[1;31m-\033[0m"


apt_install () {
  for paquet in $(cat $1)
  do
    echo $paquet
    echo "-----------------------------------------------------------" >> $LOGFILE
    echo "-----------------------------------------------------------" >> $LOGFILE
    echo $1 " >>> " $paquet >> $LOGFILE
    echo "-----------------------------------------------------------" >> $LOGFILE
    echo "-----------------------------------------------------------" >> $LOGFILE
    sudo apt install -y $paquet &>> $LOGFILE
  done

}


echo -e "[$PLUS] Mise a jour des depots"
sudo apt update &> $LOGFILE

echo -e "[$PLUS] Installation des outils courants"
apt_install $OUTILS

echo -e "[$PLUS] Installation des bibliotheques"
apt_install $LIB

echo -e "[$PLUS] Personnalisation du terminal"
apt_install $TERMINAL

echo -e "[$PLUS] Installation de dependances python"
apt_install $PYTHON

echo -e "[$PLUS] Installation d outils de dev"
apt_install $DEV

echo -e "[$PLUS] Installation d outils reseau"
apt_install $RZO

echo -e "[$PLUS] Installation d outils forensic"
apt_install $FORENSIC

echo -e "[$PLUS] Installation du theme"
apt_install $I3
cp -r dotfiles/i3 $HOME/.config/
cp -r dotfiles/rofi $HOME/.config/
sudo mv /etc/i3status.conf /etc/i3status.conf_bak
sudo cp i3status.conf /etc/


cd $HOME

echo -e "[$PLUS] Personnalisation de GDB"
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

echo -e "[$PLUS] Personnalisation de VIM"
cp dotfiles/vimrc $HOME/.virmc

echo -e "[$PLUS] Installation de Oh my ZSH"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
