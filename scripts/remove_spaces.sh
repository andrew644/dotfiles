#!/usr/bin/env bash

for f in *\ *; do mv "$f" "${f// /_}"; done
