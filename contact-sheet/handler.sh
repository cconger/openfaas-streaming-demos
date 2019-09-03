#!/bin/bash

SESSION=`uuidgen`

function clean () {
  rm -rf .tmp/"${SESSION}"*.png
}

if [ ! -d ".tmp" ]; then
  mkdir .tmp
fi

trap clean SIGINT SIGTERM

# Create a screenshot every minute
ffmpeg -i - -vf fps=fps=1/60 -f image2 .tmp/"${SESSION}"_%03d.png

montage .tmp/"${SESSION}"_*.png -geometry +0+0 -tile 3x -background transparent png:-

rm -f .tmp/"${SESSION}"_*.png
