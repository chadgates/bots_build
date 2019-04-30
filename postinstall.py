import ConfigParser

config = ConfigParser.ConfigParser()
config.read(r'/usr/local/lib/python2.7/site-packages/bots-3.3.0-py2.7.egg/bots/config/bots.ini.ini')
# config.set('jobqueue', 'enabled', 'True')
# dir monitor not started through supervisord, as 
# not working with a file system layer  
# config.set('dirmonitor1', 'path', '/dirmon')
# config.remove_section('dirmonitor2')
with open(r'/usr/local/lib/python2.7/site-packages/bots-3.3.0-py2.7.egg/bots/config/bots.ini', 'wb') as configfile:
    config.write(configfile)