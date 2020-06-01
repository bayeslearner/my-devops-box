#!/bin/bash -eux 

REPO=${GITHUB_REPO:-"rgsystemes/rgsupv-agent"}
ASSET_ID=$1

curl -L \
    -H "Accept: application/octet-stream" \
    -H "Authorization: token $GITHUB_TOKEN" \
    https://api.github.com/repos/$REPO/releases/assets/$ASSET_ID \
    -o /tmp/archive.zip
