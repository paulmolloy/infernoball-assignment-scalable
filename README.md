# infernoball-assignment-scalable


## Just run next level to decrypt and split out the hashes for the next level.
./next_level.sh next_level_num inferno_ball potfile_path 
./next_level.sh 2 testing/1_level/inferno_ball.as5 ../JohnTheRipper/run/john.pot 








#### To begin the first level start.
./begin_level.sh 1 molloyp1.as5 molloyp1.secrets
where 1 is the level you are on and .as5 is the infernoball path and .secrets is the secrets file path.
This will get all of the hashes and split them out into testing/N_level/hashes/ 
with:
  md5.hashes
  sha256.hashes etc
The original hashes and infernoball for the level are copied into the new level directory.
extract_hashes is used to read an infernoball and save the hashes to a file.

To decrypt a level with a potfile use:
python decrypt.py -i molloyp1.as5 -p ../JohnTheRipper/run/john.pot



