##########################################################
# Script to Run the Royal Bank Report
#
# Created:  mxr916 10/18/2016
# modified: 
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
echo "\n Copying file to tmp folder as a backup"
cp $FPATH/Royal_Bank_Report.txt $FPATH/tmp/Royal_Bank_Report"_"$DATE.txt

echo "\n Done Copying file to tmp folder as a backup"

echo "\nCompleted running files at $TIME on $DATE "

############################################################################
# End of Program
############################################################################
