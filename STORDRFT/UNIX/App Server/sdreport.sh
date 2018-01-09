##########################################################
# Script to Run the reports
#
# Created:  nxk927
# modified: nxk927 2/24/2015
# modified: nxk927 2/27/2017
#           added the new summary report in the run1.txt file and concaneting the summary report in the final report
#            : 05/09/2017 rxa457 - asp-781 CCN Project Team... 
#            Handle exceptions and exit during errors
#            : 07/17/2017 pxb712 - CCN Project Team... 
#            called the Script remove_crtmp.sh to Clean Crystal Report temp files 
#            : 09/13/2017 rxa457 CCN Project Team...
#                redirecting strerror and stdout to a separate log file to capture
#                  current report run error information
# modified: mxv711 11/07/2017 added unset Display for fixing the display issues JIRA : ASP-906(PuTTY X11 proxy: unable to connect to forwarded X server: 
#           Network error: Connection refused  com.crystaldecisions.sdk.occa.report.lib.ReportSDKException: Can't connect to X11 window server using 'localhost:10.0' as the value of the DISPLAY variable.
#           Error code:-2147467259 Error code name:failed ) this error cannot be produced in DEV,test or QA environments.
# modified: 01/09/2018 nxk927
#           add the sed command in this script after the concatination of the files are done to handle the page break issue.
##########################################################

unset DISPLAY 
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
dt=`date +"%m%d%Y"`
echo "\nStarted running files at $TIME on $DATE "

./pl_gain.sh /app/strdrft/sdReport/data/run1.txt > /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp_${dt}.log 2>&1

#Verify status code and the log file for any instance of Exceptions or errors; If true then exit with status code 1
status=$?
if [ $status -ne 0 ]
then
    exit 1
fi

TIME=`date +"%H:%M:%S"`

###############################################
# Description: Script to concatenate the files 
# and copy the file as a backup for future reference
###############################################
FPATH="/app/strdrft/sdReport/reports/"

echo "\n Concatenating files"

#Check for Existance of generated report files before Starting the concatenation process
if [ ! -f $FPATH/plreport.txt ] || [ ! -f $FPATH/unbooked_PL.txt ] || [ ! -f $FPATH/Store_gl_report.txt ] || [ ! -f $FPATH/Unbooked_Store_gl_report.txt ]
then
    echo "Exception occured while trying to concatenate the files- One or more of the Report txt files $FPATH/plreport.txt $FPATH/unbooked_PL.txt $FPATH/Store_gl_report.txt $FPATH/Unbooked_Store_gl_report.txt are not found"
    exit 1
fi

cat $FPATH/plreport.txt $FPATH/unbooked_PL.txt $FPATH/Store_gl_report.txt $FPATH/Unbooked_Store_gl_report.txt > $FPATH/glreport.txt
echo "\n Done Concatenating files"

sed  's/x/ /g' /app/strdrft/sdReport/reports/glreport.txt >  /app/strdrft/sdReport/reports/final/glreport.txt 

DATE=`date +"%m%d%Y"`

#Check for proper existance of the concatenated file glreport.txt
if [ ! -f $FPATH/final/glreport.txt ]
then
    echo "Exception occured while trying to copy $FPATH/glreport.txt file to a tmp folder as backup - File not found"
    exit 1
fi

echo "\n Copying file to tmp folder as a backup"
cp $FPATH/final/glreport.txt $FPATH/final/tmp/glreport"_"$DATE.txt

echo "\n Done Copying file to tmp folder as a backup"

echo "\nStarted running clean temp files at $TIME on $DATE "

# Call the Script to Clean Crystal Report temp files
./remove_crtmp.sh

echo "\n ended running clean temp files at $TIME on $DATE "

echo "\nCompleted running files at $TIME on $DATE "

exit 0
############################################################################
# End of Program
############################################################################