FROM cyrinux/jok3r-slim
LABEL maintainer="xst3nz@gmail.com"
LABEL maintainer="pentux@protonmail.com"
LABEL description="Docker Image for Jok3r - Network and Web Pentest Framework \
* Based on Kali Linux, \
* All dependencies installed, \
* All tools in toolbox installed."

# Will not prompt for questions
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root/jok3r

RUN git pull && ./install-all.sh

ADD apikeys.py .
