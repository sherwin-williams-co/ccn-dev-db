#!/bin/sh -e
#################################################################
# Script name   : gain_loss_JV.sh
#
# Description   : This script is to run the GAINLOSS_JV_PKG.CREATE_GAINLOSS_JV to load the gainloss_JV table
#
# Created  : 01/02/2015 nxk927.....
# Modified : 01/14/2015 sxt410 Added get_param.sh to spool closing date.
#            01/16/2015 axk326.....
#            Added code to invoke DRAFT.TRG file to be placed on the remote server when the GainLoass_JV process is completed
#          : 04/23/2015 axk326 CCN Project Team.....
#            Added call for date_host.sh file to pick up date_param.config file and to pull out the run date 
#            Added call for get_dateparam.sh to spool the dates to date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="gain_loss_JV"
proc_name1="ftp_draft_trg"
proc_name2="ARC_DRAFT_TRG_FILE"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=${GAINLOSS_MNTLY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc_name at $TIME on $DATE"

echo "START GAIN LOSS JV Query : Processing Started at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
GAINLOSS_JV_PKG.CREATE_GAINLOSS_JV(to_date('$DATE','MM/DD/YYYY'));
EXCEPTION
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode;
END

TIME=`date +"%H:%M:%S"`
echo "END GAIN LOSS JV Query : Processing finished at ${TIME}"  

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "GAIN_LOSS_JV process blew up." 
     cd $HOME/dailyLoad
	 ./send_err_status_email.sh GAIN_LOSS_JV_ERROR	
     echo "Successfully sent mail for the errors"
	 echo "processing FAILED at $TIME on $DATE"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

###############################################################################

###############################################################################
# BELOW PROCESS WILL INVOKE the ftp_draft_trg.sh to ftp DRAFT.TRG file
# to STDSSAPHQ server.
###############################################################################
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo -e "\nSTART ftp_draft_trg.sh : Processing Started at $TIME on $DATE"
echo -e "FTP SCRIPT CALL REPLACE"
#./ftp_draft_trg.sh >> $LOGDIR/$proc_name1"_"$TimeStamp.log 

TIME=`date +"%H:%M:%S"`
echo -e "\nEND ftp_draft_trg.sh : Processing finished at $TIME"

###############################################################################
# BELOW PROCESS WILL INVOKE the Archive_Draft_Trg.sh to Archive DRAFT.TRG file
# to Monthly Jv folder.
###############################################################################
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo -e "\nSTART ARCHIVE_DRAFT_TRG_FILE.sh : Processing Started at $TIME on $DATE"
echo -e "ARCHIVE SCRIPT CALL REPLACE"
#./ARCHIVE_DRAFT_TRG_FILE.sh >> $LOGDIR/$proc_name2"_"$TimeStamp.log 

TIME=`date +"%H:%M:%S"`
echo -e "\nEND ARCHIVE_DRAFT_TRG_FILE.sh : Processing finished at $TIME"

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name1 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name1 at ${TIME} on ${DATE}"  

exit 0
############################################################################
