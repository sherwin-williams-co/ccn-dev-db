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
#            added the absolute path while running the background process
#          : 08/23/2016 nxk927 CCN Project Team.....
#            changed the files that we consider for this process
#          : 04/20/2017 nxk927 CCN Project Team.....
#            source file changed. Using the source file provided by marcy Lee.
#          : 08/08/2017 nxk927 CCN Project Team.....
#            source file changed. Using the ach file from smart team. Also removed the condition to check for the misctran file
#            declared the path in the config file.
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh /app/banking/dev/SRA1100_bp.sh > /app/banking/dev/SRA1100_bp.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep SRA1100_bp.sh

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

# Search for the file named cmd_start.sh
while true; do
   if [ -f $initload_path/SRA10510_*.TXT ]
   then
       day=`date +%a`
       if [ $day = Sat ] || [ -f $initload_path/stores_ach_*.txt ]
          then
              sleep 60
              #This above sleep command will prevent not to miss some records while ftp is still going on
              ./SRA11000_dailyRun.sh
        fi
    fi
done

echo "process completed - but should not come to this point"
exit 1

