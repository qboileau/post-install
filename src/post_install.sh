#!/bin/bash  
#

VERSION="1.0"

clear
echo "Post install script"
echo "Author  : Quentin Boileau"
echo "Contact : quentin.boileau@gmail.com"
echo "Version : $VERSION"

if [ $EUID -ne 0 ]; then
  echo "This script must be lunched as root use : sudo $0" 1>&2
  exit 1
fi

#start by install aptitude 
apt-get -y install aptitude

echo "Make temporary ./post_install directory"
mkdir post_install
cd ./post_install

##################
# Script global variables
##################
LIST=""

#install states

#dev
bool_mercurial=false
bool_git=false
bool_meld=false
bool_lamp=false
bool_golang=false
bool_postgresql=false

#internet
bool_chrome=false
bool_skype=false

#game
bool_steam=false

#music
bool_spotify=false

#tools
bool_gparted=false
bool_terminator=false
bool_dropbox=false
bool_printer=false
bool_sublimetext=false
bool_filezilla=false

#other
bool_equinox=false
bool_wallch=false

home_menu() {
	clear
	echo "Post install script $VERSION"
	echo "Home : "
	select choix in "Developement" "Internet" "Games" "Music" "Tools" "Others" "Do install" "Exit" 
	do 
	        case $REPLY in 
	                1) dev_menu ;; 
	                2) internet_menu ;; 
	                3) games_menu ;; 
	                4) music_menu ;; 
	                5) tools_menu ;; 
	                6) others_menu ;; 
	                7) start_install ;; 
	                8) exit ;; 
	                *) echo "~ unknow choice $REPLY" ;; 
	        esac 
	done 
}

dev_menu() {
	clear
	echo "Post install script $VERSION"
	echo "Developpement : "
	select choix in "Mercurial (Hg)" "Meld" "Git" "LAMP (Apache2/PHP5/MySQL)" "GO language" "PostgreSQL 9.1" "Home menu" 
	do 
	        case $REPLY in 
	                1) bool_mercurial=true ;; 
	                2) bool_meld=true ;; 
	                3) bool_git=true ;; 
	                4) bool_lamp=true ;; 
	                5) bool_golang=true ;; 
					6) bool_postgresql=true ;;
	                7) home_menu ;; 
	                *) echo "~ unknow choice $REPLY" ;; 
	        esac 
	done 
}

internet_menu() {
	clear
	echo "Post install script $VERSION"
	echo "Internet : "
	select choix in "Google Chrome" "Skype" "Dropbox" "Home menu" 
	do 
	        case $REPLY in 
	                1) bool_chrome=true ;; 
	                2) bool_skype=true ;; 
	                3) bool_dropbox=true ;; 
	                4) home_menu ;; 
	                *) echo "~ unknow choice $REPLY" ;; 
	        esac 
	done 
}


games_menu() {
	clear
	echo "Post install script $VERSION"
	echo "Games : "
	select choix in "Steam" "Home menu" 
	do 
	        case $REPLY in 
	                1) bool_steam=true ;; 
	                2) home_menu ;; 
	                *) echo "~ unknow choice $REPLY" ;; 
	        esac 
	done 
}

music_menu() {
	clear
	echo "Post install script $VERSION"
	echo "Music : "
	select choix in "Spotify" "Home menu" 
	do 
	        case $REPLY in 
	                1) bool_spotify=true ;; 
	                2) home_menu ;; 
	                *) echo "~ unknow choice $REPLY" ;; 
	        esac 
	done 
}

tools_menu() {
	clear
	echo "Post install script $VERSION"
	echo "Music : "
	select choix in "Gparted" "Terminator" "Sublime text 2" "Printer Canon MP620" "Filezilla" "Home menu" 
	do 
	        case $REPLY in 
	                1) bool_gparted=true ;; 
	                2) bool_terminator=true ;;
	                3) bool_sublimetext=true ;; 
	                4) bool_printer=true ;; 
   			5) bool_filezilla=true ;;
	                6) home_menu ;; 
	                *) echo "~ unknow choice $REPLY" ;; 
	        esac 
	done 
}

others_menu() {
	clear
	echo "Post install script $VERSION"
	echo "Other : "
	select choix in "Wallch" "Home menu" 
	do 
	        case $REPLY in 
	                1) bool_wallch=true ;; 
	                2) home_menu ;; 
	                *) echo "~ unknow choice $REPLY" ;; 
	        esac 
	done 
}

start_install() {

	if $bool_postgresql ; then
	    install_postgresql
	fi

	if $bool_mercurial ; then
	    install_mercurial
	fi

	if $bool_meld ; then
	    install_meld
	fi

	if $bool_git ; then
	    install_git
	fi

	if $bool_lamp ; then
	    install_lamp
	fi

	if $bool_golang ; then
	    install_golang
	fi

	if $bool_skype ; then
	    install_skype
	fi

	if $bool_spotify ; then
	    install_spotify
	fi

	if $bool_gparted ; then
	    install_gparted
	fi

	if $bool_terminator ; then
	    install_terminator
	fi

	if $bool_sublimetext ; then
	    install_sublimetext
	fi

	if $bool_filezilla; then
	    install_filezilla
	fi

	if $bool_dropbox ; then
	    install_dropbox
	fi

	if $bool_printer ; then
	    install_printer
	fi

	if $bool_equinox ; then
	    install_equinox
	fi

	if $bool_wallch ; then
	    install_wallch
	fi


	echo "Start install of $LIST "
	aptitude update
	aptitude -y install $LIST

	if $bool_chrome ; then
	    install_chrome
	fi

	if $bool_steam ; then
	    install_steam
	fi
}



##################################################
#  Developement functions
##################################################

##################
#Developement - Mercurial
install_mercurial() {
	echo "Add Mercurial to list" 
	LIST=$LIST" mercurial"
}

##################
#Developement - Git
install_git() {
	echo "Add Git to list" 
	LIST=$LIST" git"
}

##################
#Developement - Go language
install_golang() {
	echo "Add Go language to list" 
	LIST=$LIST" golang"
}

##################
#Developement - Meld
install_meld() {
	echo "Add Meld to list" 
	LIST=$LIST" meld"
}

##################
#Developement - Apache2/PHP5/MySQL
install_lamp() {
	echo "Add Apache2/PHP5/MySQL to list" 
	LIST=$LIST" apache2 mysql-server php5 php5-mysql libapache2-mod-php5"
}

install_postgresql() {
	echo "Add Postgresql 9.1 to list" 
	LIST=$LIST" libpq5 postgresql-9.1 postgresql-client-9.1 postgresql-client-common postgresql-9.1-postgis pgadmin3"
}

##################################################
#  Internet functions
##################################################

##################
#Internet - Chrome Stable
install_chrome() {
	echo "Install Chrome stable"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
	dpkg -i google-chrome-stable_current_amd64.deb
}

##################
#Internet - Skype
install_skype() {
	echo "Add Skype to list" 
	LIST=$LIST" skype libasound2-plugins:i386"
}

##################
#Internet - Dropbox
install_dropbox() {
	echo "Add Dropbox to list" 
	apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E 
	LIST=$LIST" nautilus-dropbox"
}


##################################################
#  Games functions
##################################################

##################
#Games - Steam
install_steam() {
	echo "Install Steam" 
	wget http://media.steampowered.com/client/installer/steam.deb 
	dpkg -i steam.deb
}


##################################################
#  Music functions
##################################################

##################
#Music - Spotify
install_spotify() {
	echo "Prepare Spotify" 
	sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list' 
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 
	LIST=$LIST" spotify-client"
}


##################################################
#  Tools functions
##################################################

##################
#GTools - parted
install_gparted() {
	echo "Add Gparted to list" 
	LIST=$LIST" gparted"
}

##################
#Tools - Terminator
install_terminator() {
	echo "Add Terminator to list" 
	LIST=$LIST" terminator"
}

##################
#Tools - Printer Canon MP620
#https://github.com/cloudnull/MP620-630-Linux-Printer
install_printer() {
	echo "Get MP620 Printer script"
	git clone git://github.com/cloudnull/MP620-630-Linux-Printer.git
	cd ./MP620-630-Linux-Printer
	chmod +x install.sh
	sh ./install.sh
}

install_sublimetext() {
	echo "Add Sublime Text 2 to list" 
	add-apt-repository ppa:webupd8team/sublime-text-2
	LIST=$LIST" sublime-text"
}

install_filezilla() {
	echo "Add Filezilla to list" 
	LIST=$LIST" filezilla"
}
	

##################################################
#  Others functions
##################################################

##################
#Others - Equinox themes
install_equinox() {
	echo "Add Equinox themes to list" 
	add-apt-repository ppa:tiheum/equinox
	LIST=$LIST" gtk2-engines-equinox equinox-theme equinox-ubuntu-theme faenza-icon-theme faenza-dark-extras"
}

install_wallch() {
	echo "Add wallch to list" 
	LIST=$LIST" wallch"
}


###################################
# MAIN

home_menu
