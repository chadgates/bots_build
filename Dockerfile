# Version: 0.0.4
FROM ubuntu:14.04
MAINTAINER Wassilios Lytras "w.lytras@bluewin.ch"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# Install basic applications
#probably not going to need following anymore
#RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential

# following needed for Paramiko library for SFTP
RUN apt-get install -y build-essential libssl-dev libffi-dev cron

# Install Python and Basic Python Tools
RUN apt-get install -y python 
RUN apt-get install -y python-dev 
RUN apt-get install -y python-distribute 
RUN apt-get install -y python-pip

RUN pip install cherrypy
RUN pip install genshi

RUN pip install django==1.7
RUN pip install bots
#RUN mkdir -p /dir

#WORKDIR /dir
#RUN wget -O django.tar.gz https://www.djangoproject.com/download/1.7.8/tarball/
#RUN tar -xf django.tar.gz
#WORKDIR /dir/Django-1.7.8
#RUN python setup.py install

#WORKDIR /dir
#RUN wget -O bots-3.2.0.tar.gz http://sourceforge.net/projects/bots/files/bots%20open%20source%20edi%20software/3.2.0/bots-3.2.0.tar.gz/download
#RUN tar -xf bots-3.2.0.tar.gz
#WORKDIR /dir/bots-3.2.0
#RUN python setup.py install

RUN apt-get install -y python-mysqldb
RUN pip install suds-jurko
RUN pip install xlrd
RUN pip install isoweek
RUN pip install pyinotify
RUN pip install paramiko 
RUN pip install pycrypto
RUN pip install supervisor

#RUN pip install cdecimal --allow-external cdecimal

#install m3-cdecimal instead as above failed
RUN pip install m3-cdecimal

# Temporary Patch for jobqueueserver in bots 3.3.0
COPY jobqueueserver.py /usr/local/lib/python2.7/dist-packages/bots/jobqueueserver.py

# Copy Supervisord.conf file -> requires cron entries in future
COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/bin/local/supervisord"]

# start putting stuff here and folders and things  /usr/local/lib/python2.7/dist-packages/bots/config

EXPOSE 8080
EXPOSE 9001
