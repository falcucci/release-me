#!/bin/bash

# Author:       Alexsander Falcucci
# Usage:        . ./ci-changelog-it.sh
# Description:  Script to generate and push new tags on Gitlab
#               and changelog automatically. Use it always to releases.

export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

nvm install node

cd $CI_PROJECT_DIR

npm config set user 0
npm config set unsafe-perm true

python3 /version-update/version-update.py
