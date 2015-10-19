#################################################################
# Script name   : audit_files_check.sh
#
# Description   : Checks for the file  Audit_backfeed.txt and Banking_audit.txt
#                 If both files are present then kicks off the two below scripts 
#                 1)Main_CAT.sh     
#                 2)audit_ftp.sh
#
# Created  : 10/12/2015 nxk927 CCN Project Team.....
# Modified : 
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/audit_files_check.sh > $HOME/audit_files_check.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep audit_files_check.sh

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

#path where the Command file is stored
cmd_path="$HOME/batchJobs/backFeed/current"
# Search for the file named cmd_start.sh
while true; do
   if [ -f $cmd_path/Audit_backfeed.txt ] &&  [ -f $cmd_path/Banking_audit.txt ]  
   then
      cd $HOME/batchJobs/backFeed
	  sh Main_CAT.sh
      sh audit_ftp.sh
   fi
done

echo "process completed - but should not come to this point"