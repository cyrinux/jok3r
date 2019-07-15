FROM cyrinux/jok3r

LABEL maintainer="xst3nz@gmail.com"
LABEL contributor="pentux@protonmail.com"

LABEL description="Docker Image for Jok3r - Network and Web Pentest Framework \
* Based on Arch Linux, \
* All dependencies installed, \
* All tools in toolbox installed."

# Set TERM
ENV TERM xterm

# Set the locale
ENV PYTHONIOENCODING utf-8

WORKDIR /root/jok3r

RUN pacman -Syyu --noconfirm

RUN git pull && ./install-all.sh
