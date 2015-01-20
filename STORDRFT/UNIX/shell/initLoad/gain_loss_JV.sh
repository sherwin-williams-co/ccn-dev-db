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
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

#below command will create param.lst file by spooling closing date from storedrft_jv_param table.
. /$HOME/initLoad/get_param.sh

proc_name="gain_loss_JV"
proc_name1="ftp_draft_trg"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

#setting up the parameters to run
P=`cat $HOME/initLoad/param.lst`

echo "START GAIN LOSS JV Query : Processing Started at $TIME on $DATE for the date $P"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;

exec GAINLOSS_JV_PKG.CREATE_GAINLOSS_JV(to_date('$P','MM/DD/YYYY'));

exit;
END

TIME=`date +"%H:%M:%S"`
echo "END GAIN LOSS JV Query : Processing finished at ${TIME}"  

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

############################################################################

###############################################################################
# BELOW PROCESS WILL INVOKE the ftp_draft_trg.sh to ftp DRAFT.TRG file
# to STDSSAPHQ server.
###############################################################################

printf "\n START ftp_draft_trg.sh : Processing Started at $TIME on $DATE \n"
./ftp_draft_trg.sh >> $LOGDIR/$proc_name1"_"$TimeStamp.log 

TIME=`date +"%H:%M:%S"`
printf "\n END ftp_draft_trg.sh : Processing finished at $TIME \n"

###############################################################################
# BELOW PROCESS WILL INVOKE the Archive_Draft_Trg.sh to Archive DRAFT.TRG file
# to Monthly Jv folder.
###############################################################################

printf "\n START ARCHIVE_DRAFT_TRG_FILE.sh : Processing Started at $TIME on $DATE \n"
./ARCHIVE_DRAFT_TRG_FILE.sh

TIME=`date +"%H:%M:%S"`
printf "\n END ARCHIVE_DRAFT_TRG_FILE.sh : Processing finished at $TIME \n"

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name1 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name1 at ${TIME} on ${DATE}"  

exit 0
############################################################################
