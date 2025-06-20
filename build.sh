#!/bin/bash

set -o errexit
set -o pipefail

GOOGLE_REGISTRY=us-east1-docker.pkg.dev/eng-bus-01-faskqs/gar-01
GOOGLE_IMAGE_TAG=${1:-v1.0.1}
GOOGLE_IMAGE=$GOOGLE_REGISTRY/steveszabo/webapp:$GOOGLE_IMAGE_TAG

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
