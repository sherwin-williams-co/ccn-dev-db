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
#          : 03/06/2018 sxg151 Added ccn_store_bank_card_file_ftp.sh to FTP the files to SMIS Team instead email
#          : 03/15/2018 rxv940 CCN project Team....
#                              Passing the file names as input to the FTP script
#                              Removed unnecssary file renames. Rather, passing timestamp to Oracle call
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="generate_store_bank_card_file"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
RUNDATE=`date --date="yesterday" +%m/%d/%Y`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE" >> $LOGDIR/$proc"_"$TimeStamp.log

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
CCN_BATCH_PROCESS.GENERATE_STORE_BANK_CARD_FILE('$TimeStamp');
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

   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Process to generate store bank card file executed successfully for $RUNDATE at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log


# Call ccn_store_bank_card_file_ft to FTP the files
TIME=`date +"%H:%M:%S"`
echo "FTP'ing the files for $proc started at ${TIME} on ${DATE}"                                     >> $LOGDIR/$proc"_"$TimeStamp.log
$HOME/batchJobs/ccn_store_bank_card_file_ftp.sh "merchtb_$TimeStamp.dat" "STORE_BANK_CARD_SERIAL_$TimeStamp.dat" >> $LOGDIR/$proc"_"$TimeStamp.log

status=$?
if test $status -ne 0
   then
     echo "processing FAILED while FTP'ing at ${TIME} on ${DATE}"
     exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "FTP'ing the files for $proc finished at ${TIME} on ${DATE}"                                    >> $LOGDIR/$proc"_"$TimeStamp.log
echo "Processing finished for $proc at ${TIME} on ${DATE}"                                           >> $LOGDIR/$proc"_"$TimeStamp.log

exit 0 
#######################################################################################################################
