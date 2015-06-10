# Version: 0.0.2
FROM ubuntu:14.04
MAINTAINER Wassilios Lytras "w.lytras@bluewin.ch"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# Install basic applications
RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential

# Install Python and Basic Python Tools
RUN apt-get install -y python 
RUN apt-get install -y python-dev 
RUN apt-get install -y python-distribute 
RUN apt-get install -y python-pip

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

RUN apt-get install -y python-mysqldb
RUN pip install suds
RUN pip install xlrd
RUN pip install isoweek
RUN pip install pyinotify
RUN pip install paramiko 
RUN pip install cdecimal --allow-external cdecimal

# start putting stuff here and folders and things  /usr/local/lib/python2.7/dist-packages/bots/config

EXPOSE 8080