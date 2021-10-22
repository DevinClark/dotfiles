#!/usr/bin/env bash

cd "$1" && git rev-parse --abbrev-ref HEAD || echo "?"
