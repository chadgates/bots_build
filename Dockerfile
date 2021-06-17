# Version: 3.2.1
FROM python:2.7-slim
LABEL maintainer="w.lytras@bluewin.ch"

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential libssl-dev libffi-dev python-dev

# Install PostgreSQL Driver for Python2
RUN apt-get install -y --no-install-recommends libpq-dev
RUN pip install psycopg2

# Install MySQL Driver for Python 2
RUN apt-get install -y --no-install-recommends python-mysqldb

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

# Add Crontab file
COPY crontab /usr/local/lib/python2.7/site-packages/bots/config/


# Copy Supervisord.conf file 
COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/local/bin/supervisord"]

# Map persisted files to following directories: 
# /usr/local/lib/python2.7/site-packages/bots/config
# /usr/local/lib/python2.7/site-packages/bots/botssys
# /usr/local/lib/python2.7/site-packages/bots/usersys

# BOTS Management Interface
EXPOSE 8080
# Supervisord HTTP Server
EXPOSE 9001