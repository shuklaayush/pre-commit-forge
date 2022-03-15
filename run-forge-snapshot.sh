#!/usr/bin/env bash

SNAPSHOT_FILE=".gas-snapshot"
ARGS="$@"

while (( "$#" )); do
  if [[ "$1" == "--snap" && -n "$2" ]]; then
    SNAPSHOT_FILE=$2
    break
  fi
  shift
done

forge snapshot $ARGS
if [[ $? -ne 0 ]]; then
  echo "forge snapshot failed"
  exit 1
fi

git add "$SNAPSHOT_FILE"
git commit --amend --no-edit --no-verify
