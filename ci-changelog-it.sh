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

nvm install 10.18.1

cd $CI_PROJECT_DIR

npm config set user 0
npm config set unsafe-perm true

npm_config_user=root

npm install node

npm i -g @falcucci/changelog-it@latest

TAG=`eval 'git describe --abbrev=0 --tags $(git rev-list --tags --skip=1 --max-count=1)'`
echo "latest tag $TAG"

while :
do
  NTAG=`eval 'git describe --tags $(git rev-list --tags --max-count=1)'`
  if [ "$NTAG" != $TAG ]
  then
    echo "new tag $NTAG"
    changelog-it --range ${TAG}...${NTAG} --release --gmud
  fi
  break
done
