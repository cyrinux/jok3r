#!/usr/bin/env bash

print_title() {
    BOLD_GREEN=$(tput bold ; tput setaf 2)
    NORMAL=$(tput sgr0)
    echo "${BOLD_GREEN} $1 ${NORMAL}"
}

print_yellow() {
    BOLD_YELLOW=$(tput bold ; tput setaf 3)
    NORMAL=$(tput sgr0)
    echo "${BOLD_YELLOW} $1 ${NORMAL}"
}

print_delimiter() {
    echo
    echo "-------------------------------------------------------------------------------"
    echo
}

pkg_install() {
    pacman -Syy --noconfirm --overwrite --needed "$@"
}

pkg_update() {
    pacman -Syy --noconfirm --overwrite --needed "$@"
}

clear

echo
echo
print_title "=============================="
print_title "Install dependencies for Jok3r"
print_title "=============================="
echo
echo

# Make sure we are root !
if [ "$EUID" -ne 0 ]; then
    print_yellow "Please run as root"
    exit
fi

# Make sure we are on Archlinux
if [[ `(lsb_release -sd || grep ^PRETTY_NAME /etc/os-release) 2>/dev/null | grep "Arch Linux"` ]]; then
    echo "Arch Linux detected !"
else
    print_yellow "Arch Linux not detected ! There is no guarantee Jok3r will be working correctly."
    print_yellow "It is strongly advised to use Docker environment instead !"
fi
echo
echo

# -----------------------------------------------------------------------------

print_title "[~] Update repositories"
pacman -Syyu
print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v git)" ]; then
    print_title "[~] Install git ..."
    pkg_install git
else
    print_title "[+] Git is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v msfconsole)" ]; then
    print_title "[~] Install Metasploit ..."
    pkg_install metasploit
else
    print_title "[+] Metasploit is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v nmap)" ]; then
    print_title "[~] Install Nmap ..."
    pkg_install nmap
else
    print_title "[+] Nmap is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v tcpdump)" ]; then
    print_title "[~] Install tcpdump ..."
    pkg_install tcpdump
else
    print_title "[+] tcpdump is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v npm)" ]; then
    print_title "[~] Install NodeJS ..."
    pkg_install nodejs-lts-dubnium
else
    print_title "[+] NodeJS is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------

print_title "[~] Install Python 2.7 + 3, ruby and useful related packages (if missing)"
pkg_install base-devel gcc \
    ruby-bundler ruby-snmp \
    python python-regex python-argparse python-pip \
    python-setuptools \
    python-setuptools python-distutils-extra \
    python-ipy python-pymysql python-paramiko \
    python-psycopg2 python-stem python-pysocks \
    python-ajpy python-colorlog python-beautifulsoup4 python2-bs4 \
    python-parsel python-soupsieve \
    python-humanfriendly python-pyasn1
    
pkg_install python2 python2-nmap python2-ajpy python2-colorlog python2-paramiko python2-psycopg2 python2-pip \
    python2-beautifulsoup4 python2-bs4 python2-soupsieve python2-argparse python2-setuptools    
print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v jython)" ]; then
    print_title "[~] Install Jython"
    pkg_install jython
else
    print_title "[+] Jython is already installed"
fi
print_delimiter


# -----------------------------------------------------------------------------

#     print_title "[~] Install Ruby latest + old version (2.3) required for some tools"
#     sudo pkg_install ruby ruby-dev
#     curl -sSL https://get.rvm.io | bash
#     source /etc/profile.d/rvm.sh
#     if ! grep -q "source /etc/profile.d/rvm.sh" ~/.bashrc
#     then
#         echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc
#     fi
#     # Make sure rvm will be available
#     if ! grep -q "[[ -s /usr/local/rvm/scripts/rvm ]] && source /usr/local/rvm/scripts/rvm" ~/.bashrc
#     then
#         echo "[[ -s /usr/local/rvm/scripts/rvm ]] && source /usr/local/rvm/scripts/rvm" >> ~/.bashrc
#     fi
#     source ~/.bashrc
# fi

# if ! rvm list | grep -q "ruby-2.4"
# then
#     print_title "[~] Install Ruby old version (2.4) required for some tools"
#     pkg_install ruby-psych
#     pkg_install libssl1.0-dev
#     rvm install 2.4
# fi

# if ! rvm list | grep -q "ruby-2.5"
# then
#     print_title "[~] Install Ruby 2.5 (default)"
#     rvm install ruby-2.5
#     rvm --default use 2.5
#     gem install ffi
#     rvm list
# fi

# print_delimiter

# print_title "[~] Update Ruby bundler"
# gem install bundler
# print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v perl)" ]; then
    print_title "[~] Install Perl and useful related packages"
    pkg_install perl
else
    print_title "[+] Perl is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v php)" ]; then
    print_title "[~] Install PHP"
    pkg_install php
else
    print_title "[+] PHP is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------

if ! [ -x "$(command -v java)" ]; then
    print_title "[~] Install Java"
    pkg_install jdk-openjdk
else
    print_title "[+] Java is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------
# We should make a decision about which tool to use, aquatone is the lighter 

if ! [ -x "$(command -v firefox)" ]; then
    print_title "[~] Install Firefox (for HTML reports and web screenshots)"
    pkg_install firefox
else
    print_title "[+] Firefox is already installed"
fi
print_delimiter

if ! [ -x "$(command -v aquatone)" ]; then
    print_title "[~] Install Aquatone (for HTML reports and web screenshots)"
    pkg_install aquatone
else
    print_title "[+] Aquatone is already installed"
fi
print_delimiter

if ! [ -x "$(command -v geckodriver)" ]; then
    print_title "[~] Install Geckodriver (for web screenshots)"
    pkg_install geckodriver
else
    print_title "[+] Geckodriver is already installed"
fi
print_delimiter

# -----------------------------------------------------------------------------

print_title "[~] Install other required packages (if missing)"
pkg_install lzip libxml2 unixodbc \
    gcc make automake patch openssl \
    smbclient bind-tools libffi gmp \
    bc perl-libwhisker2 perl-libwww postgresql \
    postgresql haskell-postgresql-libpq net-tools
print_delimiter

# -----------------------------------------------------------------------------

print_title "[~] Install Python3 libraries required by Jok3r (if missing)"
pkg_update pcre python-regex python-sqlalchemy python-sqlalchemy-utils python-six python-blessed \
    python-colored python-colorlog python-colorama python-humanfriendly python-requests python-selenium python-pillow python-shodan \
    python-enlighten python-cmd2 python-tld python-ansi2html python-prettytable python-python-libnmap \
    python-urllib3 python-beautifulsoup4
print_title "[~] Install Python3 libraries required by Jok3r (if missing)"
pip3 install -r requirements.txt
print_delimiter


# -----------------------------------------------------------------------------
print_title "[~] Dependencies installation finished."
print_title "[~] IMPORTANT: Make sure to check if any error has been raised"
echo
