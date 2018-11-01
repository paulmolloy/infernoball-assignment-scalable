#!/bin/bash
# Script to split the hashes out into individual files for each hash function.
# Paul Molloy 
# 15323050
#$1 = original hashfile name.
file="$1"
mkdir hashes
cd hashes
cp ../"$file" test.hashes
grep "argon" test.hashes > argon.hashes && grep -F -v argon test.hashes  > test.hashes.tmp && mv test.hashes.tmp test.hashes 
# grep '\$1\$' test.hashes > md5.hashes && grep -F -v "\$1\$" test.hashes  > test.hashes.tmp && mv test.hashes.tmp test.hashes 
grep '\$6\$' test.hashes > sha512.hashes && grep -F -v "\$6\$" test.hashes  > test.hashes.tmp && mv test.hashes.tmp test.hashes 
grep '\$pbkdf2-sha256\$' test.hashes > pbkdf2-sha256.hashes && grep -F -v "\$pbkdf2-sha256\$" test.hashes  > test.hashes.tmp && mv test.hashes.tmp test.hashes 
echo "Saved argon.hashes"
echo "Saved pbkdf2-sha256.hashes"
echo "Saved sha512.hashes"
echo "Saved sha1.hashes"
echo "in dir "
pwd
cp test.hashes sha1.hashes
