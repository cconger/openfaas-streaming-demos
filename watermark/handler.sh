#!/bin/sh

while IFS='=' read -r -d '&' key value; do
  case $key in
    image)
      IMAGE=$value
      ;;
    opacity)
      OPACITY=$value
      ;;
  esac
done <<EOF
${Http_Query}&
EOF

if [ -z "$IMAGE" ]; then
  # Default to the openfaas image
  IMAGE="https://avatars2.githubusercontent.com/u/27013154?s=50&v=4"
fi

if [ -z "$OPACITY"]; then
  OPACITY=0.7
fi

ffmpeg -i - -i $IMAGE -filter_complex "[1:v]colorchannelmixer=aa=$OPACITY[fg];[0][fg]overlay=10:10" -f matroska -
