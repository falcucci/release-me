#!/bin/bash
# Author:       Alexsander Falcucci
# Usage:        . ./apk-builder.sh <environment>
# Description:  Script to generate and push your APK on Google Drive
#               in a specific folder automatically.
#               Please, read the README for more details.

BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
RESET='\033[0m'

# return 1 if global command line program installed, else 0
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

# return a variable in your .env
read_var() {
  VAR=$(grep $1 $2 | xargs)
  IFS="=" read -ra VAR <<< "$VAR"
  echo ${VAR[1]}
}

# name of the project
APP=${PWD##*/}

# delete older
rm -rf ./android/app/build/outputs/apk/release/app-release.apk

environment=$1
ENV_FILE=".env.${environment}"
HAS_GDRIVE="$(program_is_installed gdrive)"
GOOGLE_DRIVE_FOLDER_ID=$(read_var GOOGLE_DRIVE_FOLDER_ID $ENV_FILE)

while :
do
  if [ "$environment" == "" ]
  then
    echo -e "${BPurple}Please, give the correct params."
    echo -e "Environment cannot be empty!${RESET}"
    break
  fi

  if [ ! -f $ENV_FILE ]; then
    echo -e "${BPurple}File not found! -> ${ENV_FILE}${RESET}"
    break
  fi

  if [ "$HAS_GDRIVE" == "0" ]
  then
    echo -e "${BPurple}Please, install gdrive to sent it into your google drive google drive folder!"
    echo -e "Run: brew install gdrive${RESET}"
  fi

  # update all tags
  git pull origin --tags

  TAG=`eval 'git describe --tags $(git rev-list --tags --max-count=1)'`
  echo "latest tag $TAG"

  echo -e "${BGreen}Generating APK...${RESET}"
  cd android && ./gradlew clean && ENVFILE=$ENV_FILE ./gradlew assembleRelease

  APK=./app/build/outputs/apk/release/app-release.apk

  if [ -f $APK && $HAS_GDRIVE == "1" ]; then
    gdrive \
      upload $APK \
      --name "${APP}-${TAG}-${environment}-.apk" \
      -p $GOOGLE_DRIVE_FOLDER_ID
    cd ..
  fi
  break
done
