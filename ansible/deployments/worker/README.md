## Managing consumers with supervisor 

Quick view running processes
```bash
sudo service supervisor status
```

Stop all programs
```bash
sudo supervisorctl stop all
```

Restart all programs
```bash
sudo supervisorctl restart all
```

Start only programs that belongs to the group 'mail'
```bash
sudo supervisorctl start mail:
```

## Enable webserver status
```yaml
supervisor_http_enable: true
supervisor_http_port: 9001
supervisor_http_username: admin
supervisor_http_password: admin
```

```bash
sudo service supervisor restart
```

Links :
- http://supervisord.org/
- https://symfony.com/doc/current/messenger.html#supervisor-configuration