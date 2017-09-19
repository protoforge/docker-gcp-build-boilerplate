#!/usr/bin/env bash

set -e
#set -x

WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PROJECT_ID=$(gcloud config list project | grep project | awk '{ print $3 }')
IMAGE_NAME=$(cat ${WORKDIR}/manifest.txt | awk '{print $1}')
IMAGE_TAG=$(cat ${WORKDIR}/manifest.txt | awk '{print $2}')

docker build -t us.gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG} . && \
gcloud docker -- push us.gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG} && \
echo "Published - "us.gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}
