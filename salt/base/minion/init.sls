salt-minion:
  pkg.latest:
    - name: salt-minion
  service.running:
    - names:
      - salt-minion
    - require:
      - pkg: salt-minion
    - watch:
      - file: /etc/salt/minion

/etc/salt/minion:
  file.managed:
    - source: salt://files/salt/minion
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: salt-minion
