include:
    - ssh

openssh-server:
    pkg.installed

ssh:
    service.running:
        - require:
            - pkg: openssh-client
            - pkg: openssh-server
            - file: /etc/ssh/ssh_banner
            - file: /etc/ssh/sshd_config
        - full_restart: True


/etc/ssh/authorized_keys:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 600


/etc/ssh/sshd_config:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - source: salt://ssh/sshd_config
        - require:
            - pkg: openssh-server

/etc/ssh/ssh_banner:
    file:
        - managed
        - user: root
        - group: root
        - mode: 644
        - source: salt://ssh/ssh_banner
        - require:
            - pkg: openssh-server

