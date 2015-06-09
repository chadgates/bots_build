# Version: 0.0.2
FROM ubuntu:14.04
MAINTAINER Wassilios Lytras "w.lytras@bluewin.ch"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# Install basic applications
RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip

RUN pip install cherrypy
RUN pip install genshi

RUN mkdir -p /dir

WORKDIR /dir
RUN wget -O django.tar.gz https://www.djangoproject.com/download/1.7.8/tarball/
RUN tar -xf django.tar.gz
WORKDIR /dir/Django-1.7.8
RUN python setup.py install

WORKDIR /dir
RUN wget -O bots-3.2.0.tar.gz http://sourceforge.net/projects/bots/files/bots%20open%20source%20edi%20software/3.2.0/bots-3.2.0.tar.gz/download
RUN tar -xf bots-3.2.0.tar.gz
WORKDIR /dir/bots-3.2.0
RUN python setup.py install
EXPOSE 8080