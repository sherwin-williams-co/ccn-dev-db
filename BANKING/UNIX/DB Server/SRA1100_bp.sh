#################################################################
# Script name   : SRA1100_bp.sh
#
# Description   : Checks for the file  SRA10510_*.TXT, SRA13510_*.TXT and SRA11060_*.TXT
#                 If it find all the three files,it kicks off the below script 
#                 1)SRA11000_dailyRun.sh     
#                 It will be running in the background and is for SRA1100 process.
# Created  : 10/12/2015 nxk927 CCN Project Team.....
# Modified : 01/11/2016 nxk927 CCN Project Team.....
#            Modified the script to sleep for 60 secs after the file is avaiable
#            This is to prevent kicking off the process, as the bigger files are still 
#            getting ftp'd even though they are available resulting in skipping data
#            added exit 1 at the end which should never happen, but if happens should exit with 1
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/SRA1100_bp.sh > $HOME/SRA1100_bp.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep SRA1100_bp.sh

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#path where the Command file is stored
cmd_path="$HOME/initLoad"
# Search for the file named cmd_start.sh
while true; do
   if [ -f $cmd_path/SRA10510_*.TXT ] &&  [ -f $cmd_path/SRA13510_*.TXT ]  &&  [ -f $cmd_path/SRA11060_*.TXT ]
   then
      sleep 60
	  #This above sleep command will prevent not to miss some records while ftp is still going on
	  sh $HOME/SRA11000_dailyRun.sh
   fi
done

echo "process completed - but should not come to this point"
exit 1

