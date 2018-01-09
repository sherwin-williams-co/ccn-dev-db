##########################################################
# Script to Run the reports
#
# Created:  nxk927 08/24/2017 nxk927 - CCN Project Team... 
##########################################################
. /app/banking/dev/banking.config
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\nStarted running files at $TIME on $DATE "

./SRA30040.sh /app/banking/dev/report/data/run1.txt

#Verify status code and the log file for any instance of Exceptions or errors; If true then exit with status code 1
status=$?
if [ $status -ne 0 ]
then
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "\nFinished to generate the report at $TIME on $DATE "


TIME=`date +"%H:%M:%S"`
echo "\nStarted running clean temp files at $TIME on $DATE "

# Call the Script to Clean Crystal Report temp files
./remove_crtmp.sh

echo "\n ended running clean temp files at $TIME on $DATE "

echo "\nCompleted running files at $TIME on $DATE "

exit 0
############################################################################
# End of Program
############################################################################