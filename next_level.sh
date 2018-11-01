#!/bin/bash
# Script to split the hashes out into individual files for each hash function.
# Paul Molloy 
# 15323050
#$1 = level number 1 indexed.
level="$1"
inferno_ball_location="$2"
potfile_location="$3"
#secrets_location="$3"

if [ ! -f assignment/"$level"_level.as5 ] && [ ! -f assignment/"$level"_level.secrets ]; then 
  python decrypt.py -i "$inferno_ball_location" -p "$potfile_location" -n "$level" -D assignment
  if [ ! -d  assignment/"$level"_level ]; then

    if [ -f assignment/"$level"_level.as5 ] && [ -f assignment/"$level"_level.secrets ]; then 
      mkdir assignment/"$level"_level
      cp assignment/"$level"_level.as5  assignment/"$level"_level/"$level"_level.as5
      cp assignment/"$level"_level.secrets assignment/"$level"_level/"$level"_level.secrets
      cd assignment/"$level"_level/
      python ../../extract_hashes.py -i "$level"_level.as5 -H output
      ../../split.sh output.hashes

  fi
fi

fi
