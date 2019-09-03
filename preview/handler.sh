#!/bin/sh

# Reads from stdin and outputs to stdout targetting a average of 1Mbps
ffmpeg -i - -c:v libvpx -b:v 1M -t 00:00:15 -c:a libvorbis -f webm -
