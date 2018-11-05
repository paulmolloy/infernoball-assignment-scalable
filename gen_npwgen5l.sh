#!/usr/bin/env bash
#              ^^^^-- NOT /bin/sh

for i in {1..100}; do
  uniq <(pwgen -A  5 -N 10000) | tr ' ' '\n' >> pwdgenLikely.txt

done
uniq pwdgenLikely.txt > pwdgen5nthird.txt
rm pwdgenLikely.txt
