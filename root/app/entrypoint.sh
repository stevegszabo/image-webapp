#!/bin/bash

set -o errexit

PROFILE=/vault/secrets/config

if [ -f $PROFILE ]; then
    source $PROFILE
else
    POSTGRES_USER=user
    POSTGRES_PASSWORD=pass
    export POSTGRES_USER POSTGRES_PASSWORD
fi

WEBAPP_BIND="0.0.0.0:8080"
WEBAPP_APP="app.webapp:GAPPLICATION"
WEBAPP_LEVEL="info"

gunicorn3 --bind $WEBAPP_BIND $WEBAPP_APP --log-level $WEBAPP_LEVEL --access-logfile - --error-logfile -

exit 0
