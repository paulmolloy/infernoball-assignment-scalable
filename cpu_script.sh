wget http://registrationcenter-download.intel.com/akdlm/irc_nas/vcp/13793/l_opencl_p_18.1.0.013.tgz
echo  "wget http://registrationcenter-download.intel.com/akdlm/irc_nas/vcp/13793/l_opencl_p_18.1.0.013.tgz" >>  ../code/infernoball-assignment-scalable/cpu_script.sh
ls
tar -xzvf l_opencl_p_18.1.0.013.tgz 
ls
cd l_opencl_p_18.1.0.013/
sudo apt-get install lsb-core
sudo ./install.sh 
