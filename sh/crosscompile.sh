#!/usr/bin/env bash

IMAGE_TAG="image_name_here"

docker run --rm -it -v$PWD:/workdir ${IMAGE_TAG} "$@"
