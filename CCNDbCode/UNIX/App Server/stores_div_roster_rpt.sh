#!/bin/sh
##########################################################
# Script to Run the reports
#
# modified: 12/13/2017 nxk927 CCN Project Team... 
# Added Script Comments and Handled exceptions 
##########################################################

. /app/ccn/ccn_app_server.config

CLASSHOME=$HOME/CcnJavaCode
dt=`date`
echo "START CCN REPORTS : $dt\n"

run=`cat $1`

for file in $run
do

TIME=`date +"%H:%M:%S"`
echo "Running $file at $TIME"

filename=`basename $file .rpt` 

#PATH=/usr/jdk/jdk1.7.0_17/bin:$PATH
cd "$CLASSHOME" || exit
java com.StoresDivRosterReport.StoresDivisionRosterReport $HOME/crReports/rpt/$file $HOME/crReports/reports/$filename.pdf

#Check for Existance of generated report file before Starting the conversion process
if [ ! -f /app/ccn/crReports/reports/$filename.pdf ]
    then
        echo "Exception occured while Converting /app/ccn/scripts/stores_div_roster_rpt/reports/$filename.pdf to TXT file - PDF File not found.. Breaking out of Report Generation"
        exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Completed processing $file at $TIME\n"

done
dt1=`date`

echo "END SRA30040 REPORT  : $dt1\n"

exit 0
