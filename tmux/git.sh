#!/usr/bin/env bash

cd "$1" && git describe --contains --all HEAD || echo "?"
