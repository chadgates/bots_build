# Version: 3.2.0
FROM python:2.7-alpine3.6
LABEL maintainer="w.lytras@bluewin.ch"

RUN apk update 
# Install requirements for Paramiko (Cryptography) library for SFTP
# TODO: Verify if really needed.... 
RUN apk add --no-cache libffi-dev libressl-dev

# Install PostgreSQL Driver for Python2
RUN apk add --no-cache --virtual build-deps gcc python-dev musl-dev && \
    apk add postgresql-dev

RUN pip install psycopg2

# Install MySQL Driver for Python 2
RUN apk add py-mysqldb 

# Requirement for lxml 
RUN apk add --update --no-cache libc-dev libxslt-dev

# Make installation directory and change to there
RUN mkdir /install
WORKDIR /install

# Install Python packages
COPY requirements requirements
RUN pip install -r requirements/production.txt

# BOTS installation
COPY bots-3.2.0.tar.gz bots-3.2.0.tar.gz

RUN tar -xf bots-3.2.0.tar.gz && \
    cd bots-3.2.0 && \
    python setup.py install && \
    cd ..

COPY postinstall.py postinstall.py
RUN python postinstall.py

# Install DevCron
# failed, missing hg/mercurial : RUN pip install -e hg+https://bitbucket.org/dbenamy/devcron#egg=devcron
RUN pip install https://bitbucket.org/dbenamy/devcron/get/tip.tar.gz

# Add Crontab file
COPY crontab /usr/local/lib/python2.7/dist-packages/bots/config/


# Copy Supervisord.conf file 
COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/local/bin/supervisord"]

# Map persisted files to following directories: 
# /usr/local/lib/python2.7/dist-packages/bots/config
# /usr/local/lib/python2.7/dist-packages/bots/botssys
# /usr/local/lib/python2.7/dist-packages/bots/usersys

# BOTS Management Interface
EXPOSE 8080
# Supervisord HTTP Server
EXPOSE 9001