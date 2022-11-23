#!/usr/bin/env bash

IMAGE_TAG="image_name_here"

docker run --platform=linux/amd64 --rm -it -v$PWD:/workdir ${IMAGE_TAG} "$@"
