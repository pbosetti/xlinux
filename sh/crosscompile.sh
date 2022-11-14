#!/usr/bin/env bash

CROSSCOMPILE_IMAGE="image_name_here"

docker run --platform=linux/amd64 --rm -it -v$PWD:/workdir $CROSSCOMPILE_IMAGE "$@"
