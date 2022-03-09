#!/usr/bin/env bash

SNAPSHOT_FILE=".gas-snapshot"

if [[ $? -ne 1 ]]; then
    echo "Running forge snapshot..."
    forge snapshot

    ( git ls-files --others --exclude-standard ; git diff --name-only ) | grep -qw "$SNAPSHOT_FILE"

    if [[ $? -ne 1 ]]; then
        echo "Uncommited $SNAPSHOT_FILE file"
        exit 1
    fi
fi
