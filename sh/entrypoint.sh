#!/usr/bin/env bash


if [[ $# == 0 ]];then
  cat /cross/crosscompile.sh |
    sed -e "s@image_name_here@${IMAGE_TAG}@g"
else
  exec "$@"
fi