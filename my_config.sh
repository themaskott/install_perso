#!/usr/bin/env bash

LOGFILE="install_log.txt"
OUTILS="outils.txt"
LIB="librairies.txt"
TERMINAL="terminal.txt"
PYTHON="python.txt"
DEV="dev.txt"
RZO="rzo.txt"
FORENSIC="forensic.txt"
NUMIX="theme.txt"

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
apt_install $NUMIX

cd $HOME

echo -e "[$PLUS] Personnalisation de GDB"
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

echo -e "[$PLUS] Personnalisation de VIM"
echo "syntax on" >> $HOME/.vimrc
echo "set number" >> $HOME/.vimrc

echo "set rtp+=$HOME/.local/lib/python3.9/site-packages/powerline/bindings/vim/" >> $HOME/.vimrc
echo "set laststatus=2" >> $HOME/.vimrc
echo "set t_Co=256" >> $HOME/.vimrc

echo -e "[$PLUS] Installation de Oh my ZSH"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
