read_var() {
  VAR=$(grep $1 $2 | xargs)
  IFS="=" read -ra VAR <<< "$VAR"
  echo ${VAR[1]}
}


ENV_FILE=".env"


APP_ID=$(read_var ONESIGNAL_APP_IDGE $ENV_FILE)
REST_KEY=$(read_var ONESIGNAL_REST_APP_IDGE $ENV_FILE)
TEMPLATE_ID=$(read_var ONESIGNAL_TEMPLATE_ID $ENV_FILE)
# PUT YOUR PLAYER ID
PLAYER_ID=$1


curl --include \
     --request POST \
     --header "Content-Type: application/json; charset=utf-8" \
     --header "Authorization: Basic $REST_KEY" \
     --data-binary "{\"app_id\": \"$APP_ID\",
\"contents\": {\"en\": \"English Message\"},
\"template_id\": \"$TEMPLATE_ID\",
\"include_player_ids\": [\"$PLAYER_ID\"]}" \
     https://onesignal.com/api/v1/notifications
