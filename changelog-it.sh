#!/bin/bash

# Author:       Alexsander Falcucci
# Usage:        . ./changelog-it.sh
# Description:  Script to generate and push new tags on Github
#               and changelog automatically. Use it always to releases.
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
RESET='\033[0m'

REMOTE="origin"
git remote | grep upstream
if [[ $? -eq "upstream" ]]; then
  REMOTE="upstream"
fi

# return 1 if global command line program installed, else 0
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

# update all tags
git fetch --all

TAG=`eval 'git describe --abbrev=0 --tags $(git rev-list --tags --skip=1 --max-count=1)'`
echo "latest tag $TAG"

HAS_NODE="$(program_is_installed node)"
SEMANTIC_VERSION=$1
SUMMARY=$2
#
while :
do
  if [ "$SEMANTIC_VERSION" != "" ]
  then
      # force to create a semantic version and publish to gitlab
      curl -LsS https://raw.githubusercontent.com/falcucci/versiontag/master/versiontag.sh | bash -s $SEMANTIC_VERSION --force
  fi

  if [ "$HAS_NODE" == "0" ]
  then
    echo "Please, install nodejs https://nodejs.org/en/download/"
    break
  fi

  
  NTAG=`eval 'git describe --tags $(git rev-list --tags --max-count=1)'`

  if [ "$NTAG" != $TAG ]
  then
    echo "new tag $NTAG"
    changelog-it --range ${TAG}...${NTAG} --release ${NTAG}
    # changelog-it --range ${TAG}...origin/master --release ${NTAG} --slack --summary "$SUMMARY"
  fi

  break
done
