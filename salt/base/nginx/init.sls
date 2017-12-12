epel-release: # we are installing epel-release, I swear
  pkg: # this is how you install packages in sls files?
    - installed #yeah. I'm pretty sure.

nginx: #the name of the configuration. this is the overall config
  pkg: # the state of the package. (this pkg is a module)
    - installed # we want to install the nginx package
  service.running: # if the service is running:
    - watch: # we want to watch certain things within the service
      - pkg: nginx # make sure the package is installed
      - pkg: epel-release # make sure this is installed, else how will you update nginx?
      - file: /etc/nginx/nginx.conf #make sure the configuration is installed
      - file: /etc/nginx/sites-available/default #this is another part of that config

/etc/nginx/nginx.conf: #the nginx.conf file. we are managing this
  file.managed: #we are. managing. this file.
    - source: salt://nginx/files/etc/nginx/nginx.conf #we get it from this folder, which will be in /etc/salt/nginx/files/etc/nginx/nginx.conf
    - user: root #the user
    - group: root #the group
    - mode: 640 # the chmod

/etc/nginx/sites-available/default: #the other nginx configuration file
  file.managed: #we are managing this file
    - source: salt://nginx/files/etc/nginx/sites-available/default.jinja #OMG IT'S JINJA
    - template: jinja # we have to set that this is a jinja template we're making the config from here
    - user: root #see ^
    - group: root
    - mode: 640

/etc/nginx/sites-enabled/default: #we have to manage this but not with a file, just with a symlink, so we can do this
  file.symlink: #we are managing this symlink
    - target: /etc/nginx/sites-available/default #this symlink targets this file
    - require: #however it requires something mysterious ...
      - file: /etc/nginx/sites-available/default #if the target doesn't work symlinks are kind of poop

/usr/share/nginx/html/index.html: #we should also manage the index.html here I guess, we don't need to but hey, sample configuration walkthroughs
  file.managed: #check to see if the file is managed? yes. we are of the managing.
    - source: salt://nginx/files/usr/share/nginx/html/index.html.jinja # it's a jinja template omg so
    - template: jinja # yup
    - user: root # yup.
    - group: root
    - mode: 644
