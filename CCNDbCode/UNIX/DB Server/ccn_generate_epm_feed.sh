#!/bin/sh
###############################################################################################################################
# Script name   : ccn_generate_epm_feed_file.sh
#
# Description   : This script is to run the following:
#                 CCN_EPM_FEED_PKG.GENERATE_EPM_FILES to generate the files and call ccn_epm_feed_ftp.sh script.
#
# Created       : 03/15/2018 sxg151 CCN Project Team.....
# Modified      :
#
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_generate_epm_feed_file"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
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
CCN_EPM_FEED_PKG.GENERATE_EPM_FILES();
Exception
when others then
DBMS_OUTPUT.PUT_LINE('GENERATE_EPM_FEED_FILE FAILED AT '||SQLERRM || ' : ' ||SQLCODE);
:exitCode:=2;
END;
/
exit :exitCode
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   cd $HOME
   ./send_mail.sh "GENERATE_EPM_FEED_FILE_FAIL"
   exit 1;
else
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"
fi

############################################################################
#               Call ccn_epm_feed_ftp.sh to FTP the file
############################################################################

TIME=`date +"%H:%M:%S"`
echo "FTP'ing the files for $proc started at ${TIME} on ${DATE}"                                     >> $LOGDIR/$proc"_"$TimeStamp.log

$HOME/ccn_epm_feed_ftp.sh 

status=$?
if test $status -ne 0
   then
     cd $HOME/
     ./send_mail.sh FTP_EPM_FEED_FILE_ERROR 
     echo "processing FAILED while FTP'ing at ${TIME} on ${DATE}"                                   >> $LOGDIR/$proc"_"$TimeStamp.log
     exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "FTP'ing the files for $proc finished at ${TIME} on ${DATE}"                                    >> $LOGDIR/$proc"_"$TimeStamp.log
echo "Processing finished for $proc at ${TIME} on ${DATE}"                                           >> $LOGDIR/$proc"_"$TimeStamp.log


exit 0
#######################################################################################################################