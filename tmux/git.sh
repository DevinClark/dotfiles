#!/usr/bin/env bash

cd "$1" || exit; git describe --contains --all HEAD
