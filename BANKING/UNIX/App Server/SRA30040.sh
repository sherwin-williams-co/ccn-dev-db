#!/bin/sh
##########################################################
# Script to Run the reports
#
# modified: 08/23/2017 nxk927 CCN Project Team... 
# Added Script Comments and Handled exceptions 
##########################################################

. /app/banking/dev/banking.config

CLASSHOME=$HOME/bankingJavaCode

DATE=`date +"%m-%d-%Y"`
TIME=`date +"%H:%M:%S"`
echo "START SRA30040 REPORT at $TIME on $DATE\n "

run=`cat $1`

for file in $run
do

TIME=`date +"%H:%M:%S"`
echo "Running $file at $TIME"

filename=`basename $file .rpt` 

cd "$CLASSHOME" || exit
java com.giftcardreport.GiftCardReport $HOME/CrReports/rpt/$file $HOME/CrReports/reports/$filename.pdf

#Check for Existance of generated report file before Starting the conversion process
if [ ! -f /app/banking/dev/CrReports/reports/$filename.pdf ]
    then
        echo "Exception occured while Converting /app/banking/dev/CrReports/reports/$filename.pdf to TXT file - PDF File not found.. Breaking out of Report Generation"
        exit 1
fi

cd /app/banking/dev/CrReports/scripts

TIME=`date +"%H:%M:%S"`
echo "Running Ftp script to ftp the report at $TIME on $DATE"
./SRA30040_ftp.sh

TIME=`date +"%H:%M:%S"`
echo "Ftp process completed at $TIME on $DATE"

dt=`date +"%m-%d-%Y-%H%M%S"`
mv /app/banking/dev/CrReports/reports/$filename.pdf /app/banking/dev/CrReports/reports/archive/$filename"_"$dt.pdf

TIME=`date +"%H:%M:%S"`
echo "Completed processing $file at $TIME\n"

done
echo "END SRA30040 REPORT  at $TIME on $DATE\n"

exit 0
