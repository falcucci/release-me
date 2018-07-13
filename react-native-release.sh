#!/bin/bash
# Author:       Alexsander Falcucci
# Usage:        . ./react-native-release.sh
# Description:  Script to generate and push new tags on Github
#               and changelog automatically. Use it always to releases.

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
git pull upstream --tags

TAG=`eval 'git describe --tags $(git rev-list --tags --max-count=1)'`
echo "latest tag $TAG"

HAS_CHANGELOG_GENERATOR="$(program_is_installed github_changelog_generator)"
HAS_CHANGELOG_CHANDLER="$(program_is_installed chandler)"
HAS_REACT_NATIVE_VERSION="$(program_is_installed react-native-version)"
SEMANTIC_VERSION=$1

while :
do
  if [ "$SEMANTIC_VERSION" == "" ]
  then
      echo "\nPlease, give the correct params.\n"
      echo "Semantic Versioning specification is missing!"
      break
  fi

  if [ "$HAS_CHANGELOG_GENERATOR" == "0" ]
  then
    echo "Please, install https://github.com/github-changelog-generator/github-changelog-generator"
    break
  fi

  if [ "$HAS_CHANGELOG_CHANDLER" == "0" ]
  then
    echo "Please, install https://github.com/mattbrictson/chandler"
    break
  fi

  if [ "$CHANDLER_GITHUB_API_TOKEN" == "" ]
  then
    echo "Please, generate and add an api token https://github.com/mattbrictson/chandler#option-2---set-env-variables"
    break
  fi

  if [ "$CHANGELOG_GITHUB_TOKEN" == "" ]
  then
    echo "Please, generate and add an api token https://github.com/github-changelog-generator/github-changelog-generator#github-token"
    break
  fi

  npm version $SEMANTIC_VERSION
  git push origin master --tags

  # bugfix to remove the first line of the your current changelog
  tail -n +2 "./CHANGELOG.md" > "./CHANGELOG.tmp" && mv "./CHANGELOG.tmp" "./CHANGELOG.md"

  repo_url="`git remote get-url origin`"
  user=`echo ${repo_url} | cut -d ":" -f2 | cut -d "/" -f1`
  repo=${repo_url##*/}

  # generate changelog automatically
  github_changelog_generator -u ${user} -p ${repo%%.*} \
  --enhancement-label ":rocket: **New Feature**" \
  --bugs-label ":bug: **Bug Fix**" \
  --no-pull-requests \
  --enhancement-labels 'enhancement,Enhancement,features,Features,feature' \
  --exclude-labels 'duplicate,question,invalid,wontfix,ignore,changelog ignore' \
  --base CHANGELOG.md \
  --token ${CHANGELOG_GITHUB_TOKEN}

  git commit -am ":book: update changelog"
  git push origin master

  # generate github release based on changelog
  NEW_TAG=`eval 'git describe --tags $(git rev-list --tags --max-count=1)'`
  chandler push $NEW_TAG
  break
done
