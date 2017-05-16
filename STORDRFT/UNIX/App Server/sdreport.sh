##########################################################
# Script to Run the reports
#
# Created:  nxk927
# modified: nxk927 2/24/2015
# modified: nxk927 2/27/2017
#           added the new summary report in the run1.txt file and concaneting the summary report in the final report
#			: 05/09/2017 rxa457 - asp-781 CCN Project Team... 
#			 Handle exceptions using echo as fallback_command and record them in the log file
##########################################################

#Set Error
set -e

#Echo Error and exit in the event of unknown Errors   
trap "echo Exception or Error Occured inside sdreport.sh. Exiting..; exit 1; " ERR

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\nStarted running files at $TIME on $DATE "

./pl_gain.sh /app/strdrft/sdReport/data/run1.txt

#Verify the log file for any instance of Exceptions or errors and throw error
if (grep -q -i "Exception" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log) || (grep -q -i "Error" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log)
then
	false;
fi

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

###############################################
# Description: Script to concatenate the files 
# and copy the file as a backup for future reference
###############################################
FPATH="/app/strdrft/sdReport/reports/final"

#Check for Existance of generated report files before Starting the concatenation process
if [ -f $FPATH/plreport.txt ] && [ -f $FPATH/unbooked_PL.txt ] && [ -f $FPATH/Store_gl_report.txt ] && [ -f $FPATH/Unbooked_Store_gl_report.txt ]
then
echo "\n Concatenating files"

cat $FPATH/plreport.txt $FPATH/unbooked_PL.txt $FPATH/Store_gl_report.txt $FPATH/Unbooked_Store_gl_report.txt > $FPATH/glreport.txt
echo "\n Done Concatenating files"
else
	echo "Exception occured while trying to concatenate the files- One or more of the Report txt files $FPATH/plreport.txt $FPATH/unbooked_PL.txt $FPATH/Store_gl_report.txt $FPATH/Unbooked_Store_gl_report.txt are not found"
fi

DATE=`date +"%m%d%Y"`
#Check for proper existance of the concatenated file glreport.txt
if [ -f $FPATH/glreport.txt ]
then
echo "\n Copying file to tmp folder as a backup"
cp $FPATH/glreport.txt $FPATH/tmp/glreport"_"$DATE.txt
else
	echo "Exception occured while trying to copy $FPATH/glreport.txt file to a tmp folder as backup - File not found"
fi

echo "\n Done Copying file to tmp folder as a backup"

echo "\nCompleted running files at $TIME on $DATE "

############################################################################
# End of Program
############################################################################
