#################################################################
# Script name   : deposits_dailyRun_bp.sh
#
# Description   : Checks for the file CCN08100_TCKORD_*.TXT and CCN08100_DEPTKT_*.TXT
#                 If it finds the two files,it kicks off the below script 
#                 1)deposits_dailyRun.sh     
#                 It will be running in the background and is for Daily Deposits initLoad process.
#
# Created  : 11/12/2015 jxc517 CCN Project Team.....
# Modified : 
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/deposits_dailyRun_bp.sh > $HOME/logs/deposits_dailyRun_bp.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep deposits_dailyRun_bp.sh

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#path where the Command file is stored
cmd_path="$HOME/initLoad"
# Search for the file named cmd_start.sh
while true; do
   if [ -f $cmd_path/CCN08100_TCKORD_*.TXT ] &&  [ -f $cmd_path/CCN08100_DEPTKT_*.TXT ]
   then
	  sh $HOME/deposits_dailyRun.sh
   fi
done

echo "process completed - but should not come to this point"
