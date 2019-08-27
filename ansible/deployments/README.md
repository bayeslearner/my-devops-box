## SSH configuration for Ansistrano's deployments

1. Create a new ssh key-pair using `ssh-keygen -t rsa -b 4096 -C "<email>"`
2. Go to your repository settings > Deploy Keys and create a new **read-only access** key
3. Place your new SSH private key inside the deploy/ directory : `ansible/deploy/id_rsa`  

Links :
- https://github.blog/2015-06-16-read-only-deploy-keys/
- https://help.github.com/en/articles/connecting-to-github-with-ssh
- https://help.github.com/en/articles/testing-your-ssh-connection