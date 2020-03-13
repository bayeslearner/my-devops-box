#!/bin/bash -eux

# This scripts helps testing AWX's Rest API from the command line
# To create a token, first go to http://<tower_host>/users/<id>/tokens
# Then set it as an environment variable from the command-line :
# export AWX_ACCESS_TOKEN=<token>

if [[ -z $AWX_ACCESS_TOKEN ]] ; then
  echo "AWX_ACCESS_TOKEN is not set in this context"
  exit 0;
fi

ACCESS_TOKEN=${AWX_ACCESS_TOKEN}
JOB_TEMPLATE_ID=${1:-'1'}
GIT_BRANCH=${2:-unstable}
AWX_HOST=${3:-'192.168.1.5'}
AWX_PORT=${4:-'443'}
PAYLOAD=$(jq -n -c --arg branch $GIT_BRANCH '{ extra_vars: { git_branch: $branch } }') # Survey with git_branch variable must be set and enabled in job template settings 

# Executes a job template which ID equals to $JOB_TEMPLATE_ID variable, and outputs the JSON response to stdout
curl -k -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d $PAYLOAD \
    -X POST https://${AWX_HOST}:${AWX_PORT}/api/v2/job_templates/${JOB_TEMPLATE_ID}/launch/ | jq

# You may also create a token from the command line, using the API
# To create an application, go to http://<tower_host>/applications
# Once you've got the client's application ID, you can make a curl call to create a new access token and export it as an environment variable :

# export AWX_ACCESS_TOKEN=$(curl -k --user <login>:<password> -H "Content-Type: application/json" -X POST --data '{"application": <application_id>, "scope": "write", "description": "Access token for my app"}' http://<tower_host>/api/v2/tokens/ | jq -r ".token")

# Links : 
# https://docs.ansible.com/ansible-tower/3.5.3/html/administration/oauth2_token_auth.html#application-using-password-grant-type