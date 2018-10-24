#!/bin/bash
# Script to split the hashes out into individual files for each hash function.
# Paul Molloy 
# 15323050
#$1 = level number 1 indexed.
level="$1"
inferno_ball_location="$2"
secrets_location="$3"

if [ ! -d  testing/"$level"_level ]; then
  mkdir testing/"$level"_level
  cp "$inferno_ball_location" testing/"$level"_level/inferno_ball.as5
  cp "$secrets_location" testing/"$level"_level/secrets.secrets
  cd testing/"$level"_level/
  python ../../extract_hashes.py -i inferno_ball.as5 -H output
  ../../split.sh output.hashes
fi
