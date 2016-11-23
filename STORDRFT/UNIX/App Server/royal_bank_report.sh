##########################################################
# Script to Run the Royal Bank Report
#
# Created:  mxr916 10/18/2016
# modified: gxg192 11/18/2016 1. Added logic to call the royal_bank_rpt.sh if trigger file is present
#                             2. Changes to call royal_bank_rpt_ftp.sh to FTP o/p file on main frame
##########################################################

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\nStarted running files at $TIME on $DATE "

./royal_bank_rpt.sh /app/strdrft/sdReport/data/run2.txt

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

###############################################
# Description:  
# copy the file as a backup for future reference
###############################################
FPATH="/app/strdrft/sdReport/reports/final"

DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
echo "\n Copying file to tmp folder as a backup"
cp $FPATH/Royal_Bank_Report.txt $FPATH/tmp/Royal_Bank_Report"_"$DATE"_"$TIME.txt

echo "\n Done Copying file to tmp folder as a backup"

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\nCompleted running files at $TIME on $DATE "

###############################################
# Description:  
# Process to FTP the Royal_Bank_Report.txt file to Mainframe
###############################################

echo "\nStarting FTP Process of Royal_Bank_Report.txt to Mainframe on $DATE at $TIME"

./royal_bank_rpt_ftp.sh

TIME=`date +"%H:%M:%S"`

echo "\n FTP process completed at $TIME on $DATE "

############################################################################
# End of Program
############################################################################
