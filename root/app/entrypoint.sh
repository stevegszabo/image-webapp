#!/bin/bash

set -o errexit

WEBAPP_PROFILE=${WEBAPP_PROFILE-/vault/secrets/config}
WEBAPP_VERSION=${WEBAPP_VERSION-0000000}
WEBAPP_ADDRESS=${WEBAPP_ADDRESS-0.0.0.0}
WEBAPP_PORT=${WEBAPP_PORT-8080}
WEBAPP_LOG_LEVEL=${WEBAPP_LOG_LEVEL-debug}
WEBAPP_APPLICATION=${WEBAPP_APPLICATION-app.webapp:GAPPLICATION}
WEBAPP_DATABASE=${WEBAPP_DATABASE-none}
export WEBAPP_PROFILE WEBAPP_VERSION WEBAPP_ADDRESS WEBAPP_PORT WEBAPP_LOG_LEVEL WEBAPP_APPLICATION WEBAPP_DATABASE

# shellcheck source=/vault/secrets/config
if [ -f "$WEBAPP_PROFILE" ]; then
    source "$WEBAPP_PROFILE" || exit 1
fi

gunicorn3 --bind "$WEBAPP_ADDRESS:$WEBAPP_PORT" "$WEBAPP_APPLICATION" --log-level "$WEBAPP_LOG_LEVEL" --access-logfile - --error-logfile -

exit $?
