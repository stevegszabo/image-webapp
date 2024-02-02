#!/bin/bash

set -o errexit
set -o pipefail

GOOGLE_ENVIRONMENT=engineering
GOOGLE_PROJECT=$GOOGLE_ENVIRONMENT-406619
GOOGLE_INSTANCE=$GOOGLE_ENVIRONMENT-01
GOOGLE_REGISTRY=us-east1-docker.pkg.dev/$GOOGLE_PROJECT/$GOOGLE_INSTANCE

GOOGLE_IMAGE_TAG=v1.0.0
GOOGLE_IMAGE=$GOOGLE_REGISTRY/webapp:$GOOGLE_IMAGE_TAG

docker build \
--build-arg WEBAPP_VERSION=$GOOGLE_IMAGE_TAG \
--build-arg WEBAPP_ADDRESS=0.0.0.0 \
--build-arg WEBAPP_PORT=8080 \
--build-arg WEBAPP_LOG_LEVEL=info \
--build-arg WEBAPP_APPLICATION=app.webapp:GAPPLICATION \
--build-arg WEBAPP_PROFILE=/vault/secrets/config \
--build-arg WEBAPP_DATABASE=database \
-t $GOOGLE_IMAGE .

docker push $GOOGLE_IMAGE

exit 0