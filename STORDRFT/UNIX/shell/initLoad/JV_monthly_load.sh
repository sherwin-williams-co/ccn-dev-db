#!/bin/sh
#############################################################################
# Script Name : JV_monthly_load.sh
#
# Description : This shell program will initiate the script that 
#    		    loads the Monthly benefits JV with ADP information.
#                   
# Created     : sxh487 10/02/2014
# Modified    : sxt410 01/14/2015 Added P1 parameter to pass into Procedure.
#                                 Added get_param.sh to spool closing date.
#               sxt410 01/20/2015 Added code to invoke DRAFT_DRAFT.TRG file to be 
#               placed on the remote server when the JV_monthly_load process is 
#               completed and Archive PAID_DRAFT.TRG file for Historical purpose.
##############################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

#below command will create param.lst file by spooling closing date from storedrft_param table.
./get_param.sh

proc="JV_monthly_load"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
P1=`cat $HOME/initLoad/param.lst`

echo "Processing Started for $proc at $TIME on $DATE for the date $P1"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute SD_BENEFITS_PKG.CREATE_JV(to_date('$P1','MM/DD/YYYY'));

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "Processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE} for the date $P1"  


#################################################################################
# BELOW PROCESS WILL INVOKE the ftp_paid_draft_trg.sh to ftp PAID_DRAFT.TRG file
# to STDSSAPHQ server.
#################################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
TRG_FTP="ftp_paid_draft_trg"

echo -e "\nSTART FTPing PAID_DRAFT.TRG file: Processing Started at $TIME on $DATE "

./ftp_paid_draft_trg.sh >> $LOGDIR/$TRG_FTP"_"$TimeStamp.log

echo -e "END FTPing PAID_DRAFT.TRG file: Processing finished at $TIME on $DATE\n"


#################################################################################
# BELOW PROCESS WILL INVOKE the ARCHIVE_PAID_DRAFT_TRG_FILE.sh to Archive 
# PAID_DRAFT.TRG file to Monthly Jv folder.
#################################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
ARCHIVE_TRG="arc_draft_trg_file"

echo "START Archiving PAID_DRAFT.TRG file: Processing Started at $TIME on $DATE"

./archive_paid_draft_trg_file.sh >> $LOGDIR/$ARCHIVE_TRG"_"$TimeStamp.log

echo -e "END Archiving PAID_DRAFT.TRG file: Processing finished at $TIME on $DATE \n"

exit 0 