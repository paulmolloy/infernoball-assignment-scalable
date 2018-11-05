#!/usr/bin/env bash
#              ^^^^-- NOT /bin/sh

for i in {1..100}; do
  uniq <(pwgen -0  5 -N 100000) | tr ' ' '\n' >> pwdgenLikely.txt

done
uniq pwdgenLikely.txt > pwdgen5UpperUniqueLikely.txt
rm pwdgenLikely.txt
