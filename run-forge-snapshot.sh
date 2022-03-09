#!/usr/bin/env bash

GIT_STASH_MSG="run-forge-snapshot-stash"

SNAPSHOT_FILE=".gas-snapshot"
ARGS="$@"

while (( "$#" )); do
  if [[ "$1" == "--snap" && -n "$2" ]]; then
    SNAPSHOT_FILE=$2
    break
  fi
  shift
done

git ls-files --others --exclude-standard | grep -qw "$SNAPSHOT_FILE"
if [[ $? -ne 1 ]]; then
  rm "$SNAPSHOT_FILE"
fi

git diff --name-only | grep -qw "$SNAPSHOT_FILE"
if [[ $? -ne 1 ]]; then
  git checkout -- "$SNAPSHOT_FILE"
fi

git stash --keep-index --include-untracked -m "${GIT_STASH_MSG}"
forge snapshot $ARGS
git stash list | grep -qw "${GIT_STASH_MSG}" && git stash pop -q

( git ls-files --others --exclude-standard ; git diff --name-only ) | grep -qw "$SNAPSHOT_FILE"

if [[ $? -ne 1 ]]; then
    echo "Uncommited $SNAPSHOT_FILE file"
    exit 1
fi
