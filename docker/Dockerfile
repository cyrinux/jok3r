FROM archlinux/base

# NOTE: This Dockerfile is used to rebuild Jok3r Docker Image from scratch from
# archlinux/base. It is recommended to directly pull cyrinux/jok3r image instead

LABEL maintainer="xst3nz@gmail.com"
LABEL contributor="pentux@protonmail.com"

LABEL description="Docker Image for Jok3r - Network and Web Pentest Framework \
* Based on BlackArch, \
* All dependencies installed, \
* All tools in toolbox installed."

# Set TERM
ENV TERM xterm
RUN export TERM=xterm

# Set the locale
ENV PYTHONIOENCODING utf-8

# Basic config
WORKDIR /root

# Prepare pacman, pacman
RUN pacman-db-upgrade
RUN pacman -Syyu reflector --noconfirm && \
    reflector --verbose -l 5 --protocol http --sort rate --save /etc/pacman.d/mirrorlist && \
    pacman -Rs reflector --noconfirm

RUN pacman -Syyu --noconfirm --needed sudo git wget gnupg iputils mtr vim unzip which gawk whois traceroute
RUN echo 'export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u@jok3r-docker:\[$(tput setaf 4)\]\w\\$\[$(tput sgr0)\]\[$(tput sgr0)\] "' >> /root/.bashrc
RUN echo 'export TERM=xterm' >> /root/.bashrc

# Clone jok3r
RUN echo 'jok3r() { python3 ~/jok3r/jok3r.py "$@"; }' >> /root/.bashrc
RUN git clone --single-branch --branch archlinux_docker https://github.com/cyrinux/jok3r.git 

# Install blackarch repository
RUN curl -O https://blackarch.org/strap.sh && bash strap.sh && pacman -Syyu --noconfirm yay && rm -f strap.sh

# Install Oracle repository
COPY oracle.repo /etc/pacman.d/oracle
RUN echo "Include = /etc/pacman.d/oracle" >>/etc/pacman.conf

# Add user, group sudo
RUN /usr/sbin/groupadd --system sudo && \
    /usr/sbin/useradd -m --groups sudo user && \
    /usr/sbin/sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers && \
    /usr/sbin/echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Dummy git config
RUN git config --global user.email "dummy@example.com" && git config --global user.name "Dummy Dummy"

# Install Jok3r
WORKDIR /root/jok3r
RUN ./install-all.sh

# Cleanup VM, will take some times...
RUN pacman -Qq | pacman -Syyu - && pacman -Scc --noconfirm; rm -r /usr/share/man/*; ls -d /usr/share/locale/* | egrep -v "alias|en_GB" | xargs rm -rf
