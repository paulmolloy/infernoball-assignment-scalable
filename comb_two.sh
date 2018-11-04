#!/usr/bin/env bash
#              ^^^^-- NOT /bin/sh
path="$1"
readarray -t a < "$path"   # read each line of file1 into an element of the array "a"
readarray -t b < "$path"   # read each line of file2 into an element of the array "b"
for itemA in "${a[@]}"; do
  for itemB in "${b[@]}"; do
    printf '%s%s\n' "$itemA" "$itemB"
  done
done
