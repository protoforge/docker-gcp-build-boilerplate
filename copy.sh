#!/usr/bin/env bash

set -e
#set -x

WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d "$1" ]; then
  echo "Please provide a target directory."
  exit 1
fi

if [ -e "$1/build.sh" ]; then
  cp -n "$1/build.sh" "$1/build.original"
fi

if [ -e "$1/bump_version.sh" ]; then
  cp -n "$1/bump_version.sh" "$1/bump_version.original"
fi

cp "${WORKDIR}/build.sh" "$1/build.sh" && \
cp "${WORKDIR}/bump_version.sh" "$1/bump_version.sh" && \
cp -n "${WORKDIR}/manifest.txt" "$1/manifest.txt" && \
echo "Done!"