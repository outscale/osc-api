#!/bin/bash
set -e

WHICH_SDK=$1
BRANCH="master"

if [ $# -gt 1 ]; then
    BRANCH=$2
fi

if [ -z "$API_VERSION" ]; then
    echo "API_VERSION is missing, abort"
    echo "pass API_VERSION through environment variable"
    exit 1
fi

if [ -z "$GH_TOKEN" ]; then
    echo "GH_TOKEN is missing, abort."
    echo "pass GH_TOKEN through environment variable"
    exit 1
fi

ghurl="https://api.github.com"
data="{\"ref\": \"${BRANCH}\", \"inputs\": {\"api_version\": \"$API_VERSION\"}"
curl \
    -X POST \
    -H "Authorization: token $GH_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "${data}" \
    "${ghurl}/repos/outscale/${WHICH_SDK}/actions/workflows/build.yml/dispatches"
