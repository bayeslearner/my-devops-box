#!/bin/bash -u

# The GITHUB_TOKEN must have the repo scope provided to it
# https://goobar.io/2019/12/07/manually-trigger-a-github-actions-workflow/

TOKEN=$GITHUB_TOKEN
USER=${GITHUB_USER:-"rgsystemes"}
REPO=${GITHUB_REPO:-"rgsupv-core"}
EVENT_TYPE=${GITHUB_EVENT_TYPE:-"reset-unstable-branch"}
PAYLOAD=$(jq -n -c --arg event_type $EVENT_TYPE '{ event_type: $event_type }')

curl -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token $TOKEN" \
    --request POST \
    --data $PAYLOAD \
    https://api.github.com/repos/$USER/$REPO/dispatches
