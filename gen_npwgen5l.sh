#!/usr/bin/env bash
#              ^^^^-- NOT /bin/sh

for i in {1..5}; do
  uniq <(pwgen -A  5 -N 100000) | tr ' ' '\n' >> pwdgenLikely.txt

done
uniq pwdgenLikely.txt > pwdgen5n.txt
rm pwdgenLikely.txt
