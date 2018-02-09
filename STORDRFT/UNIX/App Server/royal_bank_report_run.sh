#!/bin/sh
##########################################################
# Script to Run the Royal bank reports
#
# Created :  11/20/2017 sxh487
# modified:  02/09/2018 nxk927 added ftp scripts
##########################################################

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
dt=`date +"%m%d%Y"`
echo "\nStarted running files at $TIME on $DATE "

./royal_bank_run.sh /app/strdrft/sdReport/data/Royal_bank_reports.txt > /app/strdrft/sdReport/logs/royal_bank_rpt_${dt}.log 2>&1

#Verify status code and the log file for any instance of Exceptions or errors; If true then exit with status code 1
status=$?
if [ $status -ne 0 ]
then
    echo "\n Processing FAILED for royal_bank_run.sh at ${TIME} on ${DATE}"
    exit 1
fi

TIME=`date +"%H:%M:%S"`

####################################################
# Description: Script to concatenate the files 
# and copy the file as a backup for future reference
####################################################
FPATH="/app/strdrft/sdReport/reports"

echo "\n Concatenating files"

#Check for Existance of generated report files before Starting the concatenation process
if [ ! -f $FPATH/Royal_Bank_Debits.txt ] || [ ! -f $FPATH/Royal_Bank_Detail.txt ]
then
    echo "Exception occured while trying to concatenate the files- One or more of the Report txt files $FPATH/Royal_Bank_Debits.txt $FPATH/Royal_Bank_Detail.txt are not found"
    exit 1
fi

cat $FPATH/Royal_Bank_Debits.txt $FPATH/Royal_Bank_Detail.txt > $FPATH/Royal_Bank_Report.txt
echo "\n Done Concatenating files"

sed  's/x/ /g' /app/strdrft/sdReport/reports/Royal_Bank_Report.txt >  /app/strdrft/sdReport/reports/final/Royal_Bank_Report.txt 
DATE=`date +"%m%d%Y"`

#Check for proper existance of the concatenated file Royal_Bank_Report.txt
if [ ! -f $FPATH/Royal_Bank_Report.txt ]
then
    echo "Exception occured while trying to copy $FPATH/Royal_Bank_Report.txt file to a tmp folder as backup - File not found"
    exit 1
fi
echo "\n ftp'ing the report to main frame"
./royal_bank_rpt_ftp.sh
echo "\n ftp'ing the report to main frame completed"

echo "Ftp'ing the trigger file to have the reports loaded\n"
cd /app/strdrft/sdReport/scripts
./sd_ftp_trigger_file.sh

echo "Ftp'ing the trigger file completed\n"

echo "\n Copying file to tmp folder as a backup"
cp $FPATH/Royal_Bank_Report.txt $FPATH/tmp/Royal_Bank_Report"_"$DATE.txt

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