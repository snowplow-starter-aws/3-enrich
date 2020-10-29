#!/bin/bash


IMAGE_TAG=1.1.3
REPO=petersiemen
NAME=snowplow-stream-enrich-kinesis

docker build -t ${NAME}:${IMAGE_TAG} .
docker tag ${NAME}:${IMAGE_TAG} ${REPO}/${NAME}:${IMAGE_TAG}
docker push ${REPO}/${NAME}:${IMAGE_TAG}