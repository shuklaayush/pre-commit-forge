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

( git ls-files --others --exclude-standard ; git diff --name-only ) | grep -qw "$SNAPSHOT_FILE"

if [[ $? -ne 1 ]]; then
    echo "Uncommited $SNAPSHOT_FILE file"
    exit 1
fi
