FROM jenkins/jenkins:lts

MAINTAINER redbeard28 <https://github.com/redbeard28/jenkins_master.git>

USER root
ARG DOCKER_GID
ARG DOCKER_TCPIP


COPY plugins.txt /

RUN apt-get update && \
    apt-get -y install rsync apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && \
    apt-get -y install docker-ce

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list && \
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 && \
    sudo apt update && \
    sudo apt -y install ansible

RUN curl -fsSL -o /install-plugins.sh https://raw.githubusercontent.com/jenkinsci/docker/master/install-plugins.sh -o / && \
    chmod 755 /install-plugins.sh && \
    /bin/bash /install-plugins.sh < /plugins.txt

RUN usermod -a -G docker jenkins
RUN groupmod -g $DOCKER_GID docker

USER jenkins

