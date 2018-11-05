#!/usr/bin/env bash
#              ^^^^-- NOT /bin/sh

for i in {1..1000}; do
  uniq <(pwgen -A  5 -N 1000) | tr ' ' '\n' >> pwdgenLikely.txt

done
uniq pwdgenLikely.txt > pwdgen5nfourth.txt
rm pwdgenLikely.txt
