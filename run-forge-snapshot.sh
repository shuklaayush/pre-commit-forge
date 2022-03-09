#!/usr/bin/env bash

SNAPSHOT_FILE=".gas-snapshot"

git diff --cached --name-only | grep -qE '\.sol$'

if [[ $? -ne 1 ]]; then
    echo "Running forge snapshot..."
    forge snapshot &> /dev/null

    ( git ls-files --others --exclude-standard ; git diff --name-only ) | grep -qE "$SNAPSHOT_FILE"

    if [[ $? -ne 1 ]]; then
        echo "Uncommited $SNAPSHOT_FILE file"
        exit 1
    fi
fi
