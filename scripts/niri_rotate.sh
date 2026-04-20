#!/usr/bin/env bash

# Get the connector name (e.g. eDP-1)
OUTPUT=$(niri msg outputs | awk -F '[()]' '/^Output/ {print $2; exit}')

if [ -z "$OUTPUT" ]; then
    echo "No outputs found"
    exit 1
fi

# Get current transform
CURRENT=$(niri msg outputs | awk -v out="$OUTPUT" '
    $0 ~ "\\(" out "\\)" {found=1}
    found && /Transform:/ {print tolower($2); exit}
')

CURRENT=${CURRENT:-normal}
echo $CURRENT

# Cycle through rotations
case "$CURRENT" in
    normal) NEXT=90 ;;
    90°)     NEXT=180 ;;
    180°)    NEXT=270 ;;
    270°)    NEXT=normal ;;
    *)      NEXT=normal ;;
esac

# Apply new transform
niri msg output "$OUTPUT" transform "$NEXT"
