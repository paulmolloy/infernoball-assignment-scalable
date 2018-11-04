#!/usr/bin/env bash
#              ^^^^-- NOT /bin/sh

for i in {1..100}; do
  uniq <(pwgen -0 -A 4 -N 100000) | tr ' ' '\n' >> pwdgenLikely.txt

done
uniq pwdgenLikely.txt > pwdgen4UniqueLikely.txt
rm pwdgenLikely.txt
