#################################################################
# Script name   : deposit_ticket_bp_file.sh
#
# Description   : this scripts is the background process that will be looking for DEPOSIT_TICKET_*.txt and DEPOSIT_TICKET_*.xml  files.
#                 if both the files are present then it will kick off the deposit_ticket_ip_file_ftp.sh which checks to see if the similar file
#                 has been processed or not. If not then it wont process and send a mail saying that the file needs to be processed first
#                 for us to send the files
#
# Created  : nxk927 CCN Project Team.....
# Modified : 04/05/2016 nxk927 CCN Project Team.....
#            changed the check to be made. added the other .xml file to be present as well
#            and the shell script that was being called and added the comments.
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/deposit_ticket_bp_file.sh > $HOME/depsit_tckt_bgp_file.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep deposit_ticket_bp_file.sh

#path where the hierarchy files are stored
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

file_path="$HOME/datafiles"
archieve_path="$HOME/datafiles/archieve"


# Search for the file named DEPOSIT_TICKET_*.txt
while true; do
   if [ -s $file_path/DEPOSIT_TICKET_*.txt ] && [ -s $file_path/DEPOSIT_TICKET_*.xml ]
   then
      sh deposit_ticket_ip_file_ftp.sh
   fi
done

echo "ftp process completed for this run - but should not come to this point"
exit 0