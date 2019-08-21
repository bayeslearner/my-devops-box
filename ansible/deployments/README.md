## SSH configuration for Ansistrano's deployments

1. Go to your GitHub account and [register a new SSH public key](https://github.com/settings/keys)
2. Place your SSH private key in the deploy/ directory : `ansible/deploy/id_rsa` 
3. Test your connection using

    ```bash    
    ssh -T git@github.com
    ```    

Links :
- https://help.github.com/en/articles/connecting-to-github-with-ssh 
- https://help.github.com/en/articles/testing-your-ssh-connection