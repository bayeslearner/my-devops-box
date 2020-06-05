#!/bin/bash -eux 

# Example usage : bash download-gh-asset.sh <asset_id> /tmp/archive.tar.gz 
REPO=${GITHUB_REPO:-"rgsystemes/rgsupv-agent"}
ASSET_ID=$1
OUTPUT_PATH=$2

curl -L \
    -H "Accept: application/octet-stream" \
    -H "Authorization: token $GITHUB_TOKEN" \
    https://api.github.com/repos/$REPO/releases/assets/$ASSET_ID \
    -o $2
