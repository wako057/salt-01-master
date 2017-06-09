vim:
  pkg.installed

/etc/vim/vimrc:
    file.managed:
        - source: salt://edit/vimrc
        - skip_verify: true
        - mode: 644
        - user: root
        - group: root


/usr/share/vim/vim74/syntax/yaml.vim:
    file.managed:
        - source: salt://edit/yaml.vim
        - mode: 644
        - user: root
        - group: root
