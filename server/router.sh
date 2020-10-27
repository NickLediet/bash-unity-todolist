#!/usr/bin/env bash

ROUTE_FILE='./routes.json'
# FILTERS
FILTER_BY_METHOD="select(.method == \"$REQUEST_METHOD\")"

function __remove_quotes() {
  CLEAN_STRING=$(echo $1 | sed 's/\"//g')
  echo $CLEAN_STRING
}

function __handle_request() {
  # Get allowed routes by method
  ROUTE_EXPRESSIONS=$(cat $ROUTE_FILE | \
    jq ".routes[] | $FILTER_BY_METHOD | .route")

  for ROUTE in $ROUTE_EXPRESSIONS; do
    CLEAN_ROUTE=$(__remove_quotes $ROUTE)
    # Check if route regex matches REQUEST_URI
    if [[ $PATH_INFO =~ $CLEAN_ROUTE ]]; then
      echo 'Path validates'
      __load_controller $CLEAN_ROUTE
    fi
  done;
}

function __load_controller() {
  ROUTE_PATH=$1

  CONTROLLER=$(cat $ROUTE_FILE | \
    jq "[.routes[] | select(.route == \"$ROUTE_PATH\")][0] | .controller")
  CONTROLLER=$(__remove_quotes $CONTROLLER)

  source ./controllers/$CONTROLLER
}

# Headers are written first. The special "Status"
# header indicates the response status code
echo "Status: 200"
echo "Content-Type: text/plain"
__handle_request
