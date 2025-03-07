#!/bin/bash

# Load variables from the .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo ".env file not found"
  exit 1
fi

# Check if variables are set
if [ -z "$OUTPUT_PATH" ] || [ -z "$RTSP_URL" ] || [ -z "$CHUNK_SIZE" ]; then
  echo "One or more required variables (OUTPUT_PATH, RTSP_URL, CHUNK_SIZE) are not set in the .env file."
  exit 1
fi

# Start FFmpeg to record in segments
ffmpeg -i "$RTSP_URL" -c copy -f segment -segment_time "$CHUNK_SIZE" -segment_format mp4 -strftime 1 "$OUTPUT_PATH/%Y-%m-%d_%H-%M-%S.mp4" 