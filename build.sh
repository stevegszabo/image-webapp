#!/bin/bash

set -o errexit

DOCKER_SHA=${GITHUB_SHA=1234567}
DOCKER_TAG=$(echo $DOCKER_SHA | cut -c1-7)
DOCKER_FILE=Dockerfile

pwd
ls -la

sed -i "s/WEBAPP_VERSION=.*/WEBAPP_VERSION=$DOCKER_TAG/g" $DOCKER_FILE

exit 0