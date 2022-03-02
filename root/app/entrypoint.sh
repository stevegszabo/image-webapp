#!/bin/bash

set -o errexit

WEBAPP_PROFILE=${WEBAPP_PROFILE-/vault/secrets/config}
WEBAPP_VERSION=${WEBAPP_VERSION-0000000}
WEBAPP_ADDRESS=${WEBAPP_ADDRESS-0.0.0.0}
WEBAPP_PORT=${WEBAPP_PORT-8080}
WEBAPP_LOG_LEVEL=${WEBAPP_LOG_LEVEL-debug}
WEBAPP_APPLICATION=${WEBAPP_APPLICATION-app.webapp:GAPPLICATION}

source "$WEBAPP_PROFILE" || exit 1

gunicorn3 --bind "$WEBAPP_ADDRESS:$WEBAPP_PORT" "$WEBAPP_APPLICATION" --log-level "$WEBAPP_LOG_LEVEL" --access-logfile - --error-logfile -

exit $?
