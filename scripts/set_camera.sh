#!/usr/bin/env bash
v4l2-ctl -d /dev/video0 -c saturation=15
v4l2-ctl -d /dev/video0 -c contrast=32
