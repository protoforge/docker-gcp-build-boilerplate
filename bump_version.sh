#!/usr/bin/env bash

set -e
#set -x

if [ ! -f manifest.txt ]; then
  echo "manifest not found! Creating one..."
  read -p "Enter the app name: " new_app_name
  cleaned_app_name=$(echo $new_app_name | sed 's/\s*//g')
  echo "$cleaned_app_name 0.0.0" > "manifest.txt"
  exit 0
fi

IMAGE_NAME=$(cat manifest.txt | awk '{print $1}')
PREV_VERSION=$(cat manifest.txt | awk '{print $2}')

MAJOR_VERSION=$(echo $PREV_VERSION | cut -d '.' -f1)
MINOR_VERSION=$(echo $PREV_VERSION | cut -d '.' -f2)
LAST_MANIFEST=$(echo $PREV_VERSION | cut -d '.' -f3)
NEXT_MANIFEST=$((LAST_MANIFEST+1))

NEXT_VERSION="$MAJOR_VERSION.$MINOR_VERSION.$NEXT_MANIFEST"

echo "Previous version: $IMAGE_NAME:$PREV_VERSION"
echo "Next version: $IMAGE_NAME:$NEXT_VERSION"

# Update references
sed_cmd="s/$IMAGE_NAME:[0-9]*\.[0-9]*\.[0-9]*/$IMAGE_NAME:$NEXT_VERSION/g"
sed -i "$sed_cmd" ./*.yaml && \
echo "$IMAGE_NAME $NEXT_VERSION" > "manifest.txt"
