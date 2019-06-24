## Common commands

Syntax checking before run :
```bash
ansible-playbook ansible/playbook.yml --syntax-check
```

Run with extra vars 
```bash
ansible-playbook release.yml --extra-vars "version=1.23.45 other_variable=foo"
# With JSON: 
ansible-playbook release.yml --extra-vars '{"version":"1.23.45","other_variable":"foo"}'
```

TODO (15-06-19) :
- [ ] wkhtmltopdf
- [ ] tasks refactoring using files
- [ ] composer
- [ ] nodejs
- [ ] nginx
- [ ] elasticsearch (condition: dev)
- [ ] cerebro (condition: dev)
- [ ] yarn (condition: dev)
- [ ] cqlsh (condition: to be defined)
