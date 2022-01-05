#!/bin/bash
set -e

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
data="{\"ref\": \"master\", \"inputs\": {\"api_version\": \"$API_VERSION\"}"
curl \
    -X POST \
    -H "Authorization: token $GH_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "${data}" \
    "${ghurl}/repos/outscale/osc-sdk-rust/actions/workflows/build.yml/dispatches"
