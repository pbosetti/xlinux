#!/usr/bin/env bash


if [[ $# == 0 ]];then
  cat /cross/crosscompile.sh |
    sed -e "s@image_name_here@$CROSSCOMPILE_IMAGE@g"
else
  exec "$@"
fi