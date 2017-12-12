salt-master:
  pkg.latest:
    - name: salt-master
  service.running:
    - names:
      - salt-master
    - require:
      - pkg: salt-master
    - watch:
      - file: /etc/salt/master

/etc/salt/master:
  file.managed:
    - source: salt://files/salt/master
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: salt-master
