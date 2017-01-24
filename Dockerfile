FROM ubuntu:trusty
MAINTAINER ANNA YU

################################################################
# Inspired by
# Cloudbees/java-build-tools Docker image by Cyrille Le Clerc
################################################################

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu trusty main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe\n" >> /etc/apt/sources.list

#========================
# Miscellaneous packages
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    iproute \
    ca-certificates \
    tar zip unzip \
    wget curl \
    git \
    telnet \
    build-essential \
    less nano tree \
    python groff \
    software-properties-common python-software-properties\
    rlwrap \
    sudo \
  && rm -rf /var/lib/apt/lists/*

#================
#Java 8
#===============

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    oracle-java8-installer

RUN apt-get install oracle-java8-set-default

#========================================
# Add normal user with passwordless sudo
#========================================
RUN useradd jenkins --shell /bin/bash --create-home \
  && usermod -a -G sudo jenkins \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'jenkins:secret' | chpasswd

RUN useradd mysql --shell /bin/bash --create-home \
  && usermod -a -G sudo mysql \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'mysql:secret' | chpasswd

#===================================
# Install node.js, npm, bower
#==================================
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install --yes nodejs \
    && npm install -g npm \
    && npm install -g bower

#==========================
# Install Google Chrome
#==========================

RUN apt-get install -y xvfb

ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add - && \
    echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list && \
    apt-get update -qqy && \
    apt-get -qqy install google-chrome-stable unzip

#===============
#Last Actions
#===============

RUN apt-get clean
RUN apt-get autoremove

USER jenkins

#ENTRYPOINT ["/opt/bin/entry_point.sh"]

EXPOSE 4444
EXPOSE 3306/tcp
EXPOSE 27017
