base:
  '*':
    - default
  'role:webserver':
    - match: grain
    - nginx
  '*minion':
    - match: glob
    - minion
  '*master':
    - match: glob
    - master
