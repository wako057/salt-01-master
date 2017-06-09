


{% for username, details in pillar.get('users', {}).items() %}

{{ username }}:
  user:
    - present
    - fullname: {{ details.get('fullname','') }}
    - name: {{ username }}
    - shell: /bin/bash
    - home: /home/wister
    - group: wister
    - gid: 1100

#    {% if 'groups' in details %}
#    - groups:
#      {% for group in details.get('groups', []) %}
#      - {{ group }}
#      {% endfor %}
#    - require:
#      - group: wister
#      {% for group in details.get('groups', []) %}
#      - group: {{ group }}
#      {% endfor %}
#    {% endif %}


/etc/ssh/authorized_keys/{{username}}:
    file.managed:
        - user: {{username}}
        - group: wister
        - mode: 600
        - source: salt://users/pub_keys/{{username}}
#        - require:
#            - pkg: openssh-server

{% endfor %}