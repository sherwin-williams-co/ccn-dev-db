##########################################################
# Script to Run the reports
#
# Created:  nxk927
# modified: nxk927 2/24/2015
# modified: nxk927 2/27/2017
#           added the new summary report in the run1.txt file and concaneting the summary report in the final report
##########################################################

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\nStarted running files at $TIME on $DATE "

./pl_gain.sh /app/strdrft/sdReport/data/run1.txt

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

###############################################
# Description: Script to concatenate the files 
# and copy the file as a backup for future reference
###############################################
FPATH="/app/strdrft/sdReport/reports/final"

echo "\n Concatenating files"

cat $FPATH/plreport.txt $FPATH/unbooked_PL.txt $FPATH/Store_gl_report.txt > $FPATH/glreport.txt
echo "\n Done Concatenating files"

DATE=`date +"%m%d%Y"`
echo "\n Copying file to tmp folder as a backup"
cp $FPATH/glreport.txt $FPATH/tmp/glreport"_"$DATE.txt

echo "\n Done Copying file to tmp folder as a backup"

echo "\nCompleted running files at $TIME on $DATE "

############################################################################
# End of Program
############################################################################
