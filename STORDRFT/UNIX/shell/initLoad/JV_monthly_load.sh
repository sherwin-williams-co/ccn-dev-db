#!/bin/sh -e
################################################################################################################
# Script Name : JV_monthly_load.sh
#
# Description : This shell program will initiate the script that
#    		    loads the Monthly benefits JV with ADP information.
#
# Created     : sxh487 10/02/2014
# Modified    : sxt410 01/14/2015 Added DATE parameter to pass into Procedure.
#                                 Added get_param.sh to spool closing date.
#             : sxt410 01/20/2015 Added code to invoke DRAFT_DRAFT.TRG file to be 
#                                 placed on the remote server when the JV_monthly_load process is
#                                 completed and Archive PAID_DRAFT.TRG file for Historical purpose.
#			  : sxt410 02/04/2015 Changed trigger file name from PAID_DRAFT.TRG to DRAFT.TRG
#			  : sxt410 03/04/2015 Changed the calling package SD_BENEFIT_JV to SD_PAIDS_JV_PKG
#             : axk326 04/27/2015 Substituted hard coded date value with the date value from date_param.config file
#             : 11/18/2015 axk326 CCN Project Team.....
#               Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

proc="JV_monthly_load"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${JV_MNTLY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_PAIDS_JV_PKG.CREATE_JV(to_date('$DATE','MM/DD/YYYY'));
EXCEPTION
 when others then
 :exitCode := 2;
END;
/
exit :exitCode
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "JV_MONTHLY_LOAD process blew up." 
     cd $HOME/dailyLoad
	 ./send_err_status_email.sh JV_MONTHLY_LOAD_ERROR	
     echo "Successfully sent mail for the errors"
	 echo "processing FAILED at $TIME on $DATE"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

#################################################################################
# BELOW PROCESS WILL INVOKE the ftp_draft_trg.sh to ftp DRAFT.TRG file
# to STDSSAPHQ server.
#################################################################################
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
TRG_FTP="ftp_draft_trg"

echo -e "\nSTART FTPing DRAFT.TRG file: Processing Started at $TIME on $DATE "
echo -e "\nFTP process call "
./ftp_paid_draft_trg.sh >> $LOGDIR/$TRG_FTP"_"$TimeStamp.log

echo -e "END FTPing DRAFT.TRG file: Processing finished at $TIME on $DATE\n"

#################################################################################
# BELOW PROCESS WILL INVOKE the ARCHIVE_DRAFT_TRG_FILE.sh to Archive 
# DRAFT.TRG file to Monthly Jv folder.
#################################################################################
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
ARCHIVE_TRG="arc_draft_trg_file"

echo "START Archiving DRAFT.TRG file: Processing Started at $TIME on $DATE"
echo -e "\nArchive process call "
./archive_paid_draft_trg_file.sh >> $LOGDIR/$ARCHIVE_TRG"_"$TimeStamp.log

echo -e "END Archiving DRAFT.TRG file: Processing finished at $TIME on $DATE \n"

exit 0