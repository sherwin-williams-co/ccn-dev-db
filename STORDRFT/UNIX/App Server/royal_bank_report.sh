#################################################################################################
# Script to Run the Royal Bank Report
#
# Created:  mxr916 10/18/2016
# modified: gxg192 11/18/2016 Changes to remove call to royal_bank_rpt_ftp.sh
#                             Removed parameter passed in royal_bank_rpt.sh 
#################################################################################################

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\n Started running files at $TIME on $DATE "

./royal_bank_rpt.sh

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

echo "PROCESS royal_bank_report.sh completed AT $TIME ON $DATE"   
exit 0;

############################################################################
# End of Program
############################################################################
