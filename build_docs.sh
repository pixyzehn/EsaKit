#!/bin/bash

# Docs by jazzy
# https://github.com/realm/jazzy
# ------------------------------

jazzy \
    --clean \
    --author 'pixyzehn' \
    --author_url 'https://pixyzehn.com' \
    --github_url 'https://github.com/pixyzehn/EsaKit' \
    --module 'EsaKit' \
    --source-directory . \
    --readme 'README.md' \
    --output docs/ \
