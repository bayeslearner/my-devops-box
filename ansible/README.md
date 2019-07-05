## Ansible common commands

Syntax checking before run
```bash
ansible-playbook ansible/playbook.yml --syntax-check
```

Run with extra vars 
```bash
ansible-playbook playbook.yml --extra-vars "version=1.23.45 other_variable=foo"
# With JSON: 
ansible-playbook playbook.yml --extra-vars '{"version":"1.23.45","other_variable":"foo"}'
```

Run step by step (debug)
```bash
ansible-playbook playbook.yml --step
```

Limit execution by task tags
```bash
# show tagged tasks, default is []
ansible-playbook playbook.yml --list-tags 
# executes only tasks having the following key: tags: [ "packages" ] 
ansible-playbook playbook.yml --tags "packages" 
# executes every task but the ones having the following key: tags: [ "configure" ] 
ansible-playbook playbook.yml --skip-tags "configure"
```

Execute playbook from a specific task
```bash
# outputs every tasks to be executed
ansible-playbook playbook.yml --list-tasks
# start from a given task, till the end
ansible-playbook playbook.yml --start-at-task "configure nginx" 
```
