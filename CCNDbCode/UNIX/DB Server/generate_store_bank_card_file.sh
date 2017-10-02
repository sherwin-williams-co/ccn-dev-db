#!/bin/sh


###############################################################################################################################
# Script name   : generate_store_bank_card_file.sh
#
# Description   : This script is to run the following:
#                 CCN_BATCH_PROCESS.GENERATE_STORE_BANK_CARD_FILE
#
# Created  : 05/25/2017 sxp130 CCN Project Team.....
# Modified : 10/02/2017 rxa457 CCN project Team...
#            File name changed merchtb.dat
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="generate_store_bank_card_file"
datafilepath=$HOME/datafiles
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
RUNDATE=`date --date="yesterday" +%m/%d/%Y`
FILEDATE=`date +"%m%d%y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE" >> $LOGDIR/$proc"_"$TimeStamp.log
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
DECLARE
BEGIN
:exitCode := 0;
CCN_BATCH_PROCESS.GENERATE_STORE_BANK_CARD_FILE;
Exception
when others then
DBMS_OUTPUT.PUT_LINE('GENERATE_STORE_BANK_CARD_FILE FAILED AT '||SQLERRM || ' : ' ||SQLCODE);
:exitCode:=2;
END;
/
exit :exitCode
END
############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if test $status -ne 0
then
TIME=`date +"%H:%M:%S"`
   echo "processing FAILED for $proc at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log

   #Identify starting Line number of current run from the log file
   curlineno=`grep -n "Processing Started for generate_store_bank_card_file" $LOGDIR/$proc"_"$TimeStamp.log|cut -f1 -d:|tail -1`
   #Tail the current run log file content
   logfile=`sed -n -e ''''$curlineno''',$p' $LOGDIR/$proc"_"$TimeStamp.log`

   #Emailing the Current run's Log File
   cd $HOME/
   ./send_mail.sh STORE_BANK_CARD_ERROR "$logfile"

   echo "processing FAILED for $proc at ${TIME} on ${DATE}" 

   exit 1;
fi
cd $datafilepath
csv_files=`ls merchtb_$FILEDATE.dat*`
for file in $csv_files
do
   echo renaming $file to "merchtb_$TimeStamp.dat"
   mv $file "merchtb_$TimeStamp.dat"
done

cd $datafilepath
dat_files=`ls STORE_BANK_CARD_SERIAL_$FILEDATE.dat*`
for file in $dat_files
do
   echo renaming $file to "STORE_BANK_CARD_SERIAL_$TimeStamp.dat"
   mv $file "STORE_BANK_CARD_SERIAL_$TimeStamp.dat"
done

TIME=`date +"%H:%M:%S"`
echo "Process to generate store bank card file executed successfully for $RUNDATE at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
#######################################################################################################################
