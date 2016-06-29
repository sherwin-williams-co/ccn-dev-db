#################################################################
# Script name   : deposits_order_bp.sh
#
# Description   : this scripts is the background process that will be looking for
#                 DEPOSIT_TICKET_*.txt, DEPOSIT_TICKET_*.xml, DEPOSIT_BAG_*.xml files
#                 once it finds both the files, it FTP's the same invoking corresponding FTP script
#
# Created  : 06/09/2016 jxc517 CCN Project Team.....
# Modified : 
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh /app/banking/dev/deposits_order_bp.sh > /app/banking/dev/deposits_order_bp.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep deposits_order_bp.sh

#path where the hierarchy files are stored
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

file_path="$HOME/datafiles"

while true; do
   if [ -s $file_path/DEPOSIT_TICKET_*.txt ] && [ -s $file_path/DEPOSIT_TICKET_*.xml ]
   then
      sh deposit_ticket_order_files_ftp.sh
   fi
   if [ -s $file_path/DEPOSIT_BAG_*.xml ]
   then
      sh deposit_bag_order_files_ftp.sh
   fi
done

echo "ftp process completed for this run - but should not come to this point"
exit 0
