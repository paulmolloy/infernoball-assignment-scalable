#!/bin/bash
# Script to split the hashes out into individual files for each hash function.
# Paul Molloy 
# 15323050
#$1 = level number 1 indexed.
level="$1"
inferno_ball_location="$2"
#secrets_location="$3"

if [ ! -d  assignment/"$level"_level ]; then
  mkdir assignment/"$level"_level
  cp "$inferno_ball_location" assignment/"$level"_level/inferno_ball.as5
#  cp "$secrets_location" assignment/"$level"_level/secrets.secrets
  cd assignment/"$level"_level/
  python ../../extract_hashes.py -i inferno_ball.as5 -H output
  ../../split.sh output.hashes
fi
