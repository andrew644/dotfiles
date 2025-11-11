#!/usr/bin/env bash

#run this in the directory with chapter directories to be zipped
for dir in */; do
	parent=$(basename "$PWD")
    base=$(basename "$dir")
    zip -j -r "${parent}_${base}.zip" "$dir"
    mv "${parent}_${base}.zip" "${parent}_${base}.cbz"
done
