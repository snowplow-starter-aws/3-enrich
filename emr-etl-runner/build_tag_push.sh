#!/bin/bash


IMAGE_TAG=0.38.1
REPO=petersiemen
NAME=snowplow-emr-etl-runner

docker build -t ${NAME}:${IMAGE_TAG} .
docker tag ${NAME}:${IMAGE_TAG} ${REPO}/${NAME}:${IMAGE_TAG}
docker push ${REPO}/${NAME}:${IMAGE_TAG}