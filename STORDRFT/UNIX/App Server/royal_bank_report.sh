##########################################################
# Script to Run the Royal Bank Report
#
# Created:  mxr916 10/18/2016
# modified: gxg192 11/18/2016 1. Added logic to call the royal_bank_rpt.sh if trigger file is present
#                             2. Changes to call royal_bank_rpt_ftp.sh to FTP o/p file on main frame
##########################################################

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\n Started running files at $TIME on $DATE "

./royal_bank_rpt.sh /app/strdrft/sdReport/data/run2.txt

status=$?
TIME=`date +"%H:%M:%S"`
    
if test $status -ne 0
then
   echo "\n Processing FAILED for royal_bank_rpt.sh at ${TIME} on ${DATE}"
   exit 1;
fi
   echo "\n Completed execution of royal_bank_rpt.sh at $TIME on $DATE "

###############################################
# Description:  
# copy the file as a backup for future reference
###############################################
FPATH="/app/strdrft/sdReport/reports/final"

DT=`date +"%m%d%Y"`
TM=`date +"%H%M%S"`
echo "\n Copying file to tmp folder as a backup"
cp $FPATH/Royal_Bank_Report.txt $FPATH/tmp/Royal_Bank_Report"_"$DT"_"$TM.txt
echo "\n Copying file to tmp folder as a backup completed."

###############################################
# Description:  
# Process to FTP the Royal_Bank_Report.txt file to Mainframe
###############################################

echo "\n Starting FTP Process of Royal_Bank_Report.txt to Mainframe on $DATE at $TIME"

./royal_bank_rpt_ftp.sh

status=$?
TIME=`date +"%H:%M:%S"`
    
if test $status -ne 0
then
   echo "\n Processing FAILED for royal_bank_rpt_ftp.sh at ${TIME} on ${DATE}"
   exit 1;
fi
   echo "\n FTP process completed at $TIME on $DATE "
   exit 0;

############################################################################
# End of Program
############################################################################