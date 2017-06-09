# salt


* salt-key -L

* salt-key -A

* salt-key -D

* salt '*' test.ping


OK

* salt '*' apache.signal restart

* salt '*' state.apply webserver

* salt '*' state.apply ssh.server

* salt '*' state.apply ssh.server &&  salt '*' service.restart sshd

* salt '*' state.apply users.group


To USE

- salt '*' service.restart sshd

- salt '*' service.restart apache2
 
- salt '*' pillar.items users




TOREAD

https://docs.saltstack.com/en/latest/ref/states/highstate.html#name-declaration


KO 

* salt '*' state.apply edit/vim

* salt '*' state.apply edit/emacs

* salt '*' state.apply apache2


* salt '*' state.apply users

* salt '*' saltutil.refresh_pillar

* salt '*' state.apply users.users

