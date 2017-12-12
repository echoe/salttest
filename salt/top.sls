base:
  '*':
    - /base/default
  '*minion':
    - match: glob
    - /base/minion
  '*master':
    - match: glob
    - /base/master
  role:webserver:
    - match: grain
    - /base/nginx

decom:
  '*':
    - /decom/default
