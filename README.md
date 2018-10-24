# infernoball-assignment-scalable
## To begin a level call
./begin_level.sh 1 molloyp1.as5 molloyp1.secrets
where 1 is the level you are on and .as5 is the infernoball path and .secrets is the secrets file path.
This will get all of the hashes and split them out into testing/N_level/hashes/ 
with:
  md5.hashes
  sha256.hashes etc
The original hashes and infernoball for the level are copied into the new level directory.





extract_hashes is used to read an infernoball and save the hashes to a file.
