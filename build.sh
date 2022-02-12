#!/bin/bash

set -o errexit

DOCKER_TAG=$(echo $GITHUB_SHA | cut -c1-7)
DOCKER_FILE=Dockerfile

sed -i "s/WEBAPP_VERSION=.*/WEBAPP_VERSION=$DOCKER_TAG/g" $DOCKER_FILE

exit 0
