##########################################################
# Script to Run the reports
#
# Created:  nxk927
# modified: nxk927 2/24/2015
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

cat $FPATH/plreport.txt $FPATH/unbooked_PL.txt > $FPATH/glreport.txt 
echo "\n Done Concatenating files"

echo "\n Copying file to tmp folder as a backup"
cp $FPATH/glreport.txt $FPATH/tmp/glreport"_"$DATE.txt

echo "\n Done Copying file to tmp folder as a backup"

echo "\nCompleted running files at $TIME on $DATE "

############################################################################
# End of Program
############################################################################
