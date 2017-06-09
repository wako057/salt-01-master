include:
    - ssh.server

extend:
    /etc/ssh/ssh_banner:
        file:
            - source: salt://ssh/ssh_banner_custom
        
