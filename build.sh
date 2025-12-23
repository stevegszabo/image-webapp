#!/bin/bash

set -o errexit
set -o pipefail

GOOGLE_REGISTRY=northamerica-northeast2-docker.pkg.dev/sandbox-01-k61cps/gar-01
GOOGLE_IMAGE_REPO=${1-steveszabo/webapp}
GOOGLE_IMAGE_TAG=${2-v1.1.2}
GOOGLE_IMAGE=$GOOGLE_REGISTRY/$GOOGLE_IMAGE_REPO:$GOOGLE_IMAGE_TAG

docker build \
--build-arg WEBAPP_VERSION=$GOOGLE_IMAGE_TAG \
--build-arg WEBAPP_ADDRESS=0.0.0.0 \
--build-arg WEBAPP_PORT=8080 \
--build-arg WEBAPP_LOG_LEVEL=info \
--build-arg WEBAPP_APPLICATION=app.webapp:GAPPLICATION \
--build-arg WEBAPP_DATABASE=database \
-t $GOOGLE_IMAGE .

docker push $GOOGLE_IMAGE

exit 0
