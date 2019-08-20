## Ansible common commands

Syntax checking before run
```bash
ansible-playbook ansible/playbook.yml --syntax-check
```

Syntax linting
```bash
ansible-lint ansible/playbook.yml
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

Step by step with increased verbosity 
```bash
# shows tasks' stdout lines during execution 
# use -vv or -vvv for even more information
ansible-playbook playbook.yml --step -v 
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

## SSH configuration for Ansistrano's deploy role 

1. Go to your GitHub account and [register a new SSH public key](https://github.com/settings/keys)
2. Place your SSH private key in the deploy/ directory : `ansible/deploy/id_rsa` 
3. Test your connection using

    ```bash    
    ssh -T git@github.com
    ```    

Links :
- https://help.github.com/en/articles/connecting-to-github-with-ssh 
- https://help.github.com/en/articles/testing-your-ssh-connection