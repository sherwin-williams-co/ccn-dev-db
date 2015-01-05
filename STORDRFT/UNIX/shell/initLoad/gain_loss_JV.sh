#!/bin/sh
#################################################################
# Script name   : gain_loss_JV.sh
#
# Description   : This script is to run the GAINLOSS_JV_PKG.CREATE_GAINLOSS_JV to load the gainloss_JV table
#
# Created  : 01/02/2015 nxk927.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="gain_loss_JV"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"


##setting up the parameters to run
P=`cat $HOME/Reports/param.lst`

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

exit 0
############################################################################
