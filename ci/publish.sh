#!/bin/bash

# Script based on code from
#   https://github.community/t/how-to-create-full-release-from-command-line-not-just-a-tag/916
token=${CI_PUBLISH_TOKEN}
repo=black-parrot/riscv-gnu-toolchain

# TODO: Change tag and release names
upload_url=$(curl -s -H "Authorization: token $token"  \
     -d '{"tag_name": "vtest.test", "name":"release-0.0.2","body":"this is a test release"}'  \
     "https://api.github.com/repos/$repo/releases" | jq -r '.upload_url')

upload_url="${upload_url%\{*}"

echo "uploading asset to release to url : $upload_url"

curl -s -H "Authorization: token $token"  \
        -H "Content-Type: application/zip" \
        --data-binary @release.tgz \
        "$upload_url?name=release.tgz&label=release.tgz"
