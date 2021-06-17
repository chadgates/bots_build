# The BOTS Dockerfile

## Scope
This is only for BOTS Version 3.2. For the forked version of BOTS-EDI (3.3), check the repository of that version for docker files: https://github.com/bots-edi/bots/tree/master/compose

## Introduction 
This dockerized version should provide a quick installable version of BOTS that runs "out of the box". 

The file contains a dockerized version with all optional functionalities activiated in BOTS: 

1. Web-Server (default)
2. Job-Queue 

In addition, following tools are used to control the environment: 

1. Supervisor to manage start up services 
2. Devcron to manage cron-like jobs


## Docker Compose File
The docker compose file stored at the root of this repo, may be used to create the instance of BOTS by issueing: 

	docker-compose up -d
	

Docker will then build BOTS based Python 2.7 slim image. It builds with Postgres and MySQL support. 

Supervisor's http log-in can be password protected through environment variables, here defined as SUPERVUSER and SUPERVPASS. 

Port 8080 is used to provide BOTS Web interface
Port 9001 is used for Supervisor HTTP interface

	version: '3'
	services:
  	  bots-server:
  	    build:
          context: .
          dockerfile: Dockerfile
        ports:
          - "0.0.0.0:8080:8080"
          - "0.0.0.0:9001:9001"
        environment:
          - SUPERVUSER=bots
          - SUPERVPASS=botsbots
        command: /usr/local/bin/supervisord -c /etc/supervisor/supervisord.conf	

After the build, one can connect to the terminal as follows: 

	docker exec -i -t bots_build_bots-server_1 /bin/sh

To share local directories with the dockerized BOTS instance, add following to the corresponding entries (example below)docker-compose file. 

	volumes:
      - ./config:/usr/local/lib/python2.7/site-packages/bots/config
      - ./botssys:/usr/local/lib/python2.7/site-packages/bots/botssys
      - ./usersys:/usr/local/lib/python2.7/site-packages/bots/usersys

## Connecting


BOTS then runs on http://localhost:8080 
Supervisord run on http://localhost:9001 

For both, the initial credentials are: 
user: bots
password: botsbots
	
## The postinstall file
The postinstall changes the default bots.ini to enable: 
- job-queue 
- directory monitoring placeholder is there

## Supervisord 
Startup definitions are defined in the supervisord file. 
Read more here: [Supervisord.org](http://supervisord.org)

## crontab
The crontab file is copied to the bots/config directory from where the dev-cron is started. When the file is changed, the service may require to be restarted to get the updates (untested..., but definitly if the host is shared from the host). 
Read more here: [DevCron](https://github.com/dbenamy/devcron)

## Bots
Bots sourceforge web site: http://bots.sourceforge.net
Wiki/documentation: http://http://bots.readthedocs.io
Bots is licenced under GNU GENERAL PUBLIC LICENSE Version 3; for full text: http://www.gnu.org/copyleft/gpl.html
Commercial support by EbberConsult, http://www.ebbersconsult.com

The source file added to this repository is simply for convenience on deployment, as download failed in Alpine Linux. 
This should be patched/fixed eventually. 
 
## License
All files except for the bots source file bots-3.2.0.tar.gz are under MIT License. 
