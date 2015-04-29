#!/bin/sh
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
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

#below command will create param.lst file by spooling closing date from storedrft_jv_param table.
#. /$HOME/initLoad/get_dateparam.sh

proc_name="gain_loss_JV"
proc_name1="ftp_draft_trg"
proc_name2="ARC_DRAFT_TRG_FILE"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
P1=${GAINLOSS_MNTLY_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME

echo "Processing Started for $proc_name at $TIME for the date $P1"

echo "START GAIN LOSS JV Query : Processing Started at $TIME for the date $P1"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;

exec GAINLOSS_JV_PKG.CREATE_GAINLOSS_JV(to_date('$P1','MM/DD/YYYY'));

exit;
END

TIME=`date +"%H:%M:%S"`
echo "END GAIN LOSS JV Query : Processing finished at ${TIME}"  

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${GAINLOSS_MNTLY_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} for the date ${P1}"  

###############################################################################

###############################################################################
# BELOW PROCESS WILL INVOKE the ftp_draft_trg.sh to ftp DRAFT.TRG file
# to STDSSAPHQ server.
###############################################################################
TIME=`date +"%H:%M:%S"`
P1=${GAINLOSS_MNTLY_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME

echo -e "\nSTART ftp_draft_trg.sh : Processing Started at $TIME for the date $P1"
./ftp_draft_trg.sh >> $LOGDIR/$proc_name1"_"$TimeStamp.log 

TIME=`date +"%H:%M:%S"`
echo -e "\nEND ftp_draft_trg.sh : Processing finished at $TIME"

###############################################################################
# BELOW PROCESS WILL INVOKE the Archive_Draft_Trg.sh to Archive DRAFT.TRG file
# to Monthly Jv folder.
###############################################################################
TIME=`date +"%H:%M:%S"`
P1=${GAINLOSS_MNTLY_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME

echo -e "\nSTART ARCHIVE_DRAFT_TRG_FILE.sh : Processing Started at $TIME for the date $P1"
./ARCHIVE_DRAFT_TRG_FILE.sh >> $LOGDIR/$proc_name2"_"$TimeStamp.log 

TIME=`date +"%H:%M:%S"`
echo -e "\nEND ARCHIVE_DRAFT_TRG_FILE.sh : Processing finished at $TIME"

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${GAINLOSS_MNTLY_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name1 at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc_name1 at ${TIME} for the date ${P1}"  

exit 0
############################################################################
