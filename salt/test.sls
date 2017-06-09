{% set myenvvar = salt['network.hw_addr']('eth0') %}
{% if myenvvar %}

Create a file with contents from an environment variable:
  file.managed:
    - name: /tmp/hello
    - contents: {{ salt['network.hw_addr']('eth0') }}

{% else %}

Fail - no environment passed in:
  test.fail_without_changes

{% endif %}



#############################


# exemple pour un repertoire
/etc/ssh/authorized_keys:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 600


