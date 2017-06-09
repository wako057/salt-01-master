apache2:
  pkg.installed



extend:
  apache2:
    service:
      - running
      - watch:
        - file: dev

/var/www/html/index.html:                   # ID declaration
  file:                                     # state declaration
    - managed                               # function
    - source: salt://apache2/index.html   # function arg
    - require:                              # requisite declaration
      - pkg: apache2                        # requisite reference


dev:
  file:
    - managed
    - name: /etc/apache2/sites-available/dev.conf
    - source: salt://apache2/sites-available/dev.conf
    - require:
      - pkg: apache2
