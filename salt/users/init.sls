
shared:
  user.present:
    - fullname: legacy account
    - shell: /dev/null
    - home: /home/shared/
    - uid: 1100
    - gid: 1100

/home/shared:
  file.directory:
    - user: shared
    - group: shared
    - dir_mode: 775
    - file_mode: 775


/home/shared/.bash_aliases:
    file.managed:
        - user: shared
        - group: shared
        - mode: 644
        - source: salt://shell/debian_bash_aliases

/root/.bashrc:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - source: salt://shell/debian_bashrc_root
