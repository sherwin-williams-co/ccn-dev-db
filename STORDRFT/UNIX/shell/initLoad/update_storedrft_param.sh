#!/bin/sh
#############################################################################
# Script Name : update_storedrft_param.sh
#
# Description : This shell script will update storedrft_param table.
#               This shell script will also create param.lst file in Reports folder
# 
# Created     : 04/22/2015 jxc517 Store Draft Project
# Modified    : 04/24/2015 axk326 STore Draft Project 
#               Changed date field as per the column name change
#               Adding date logic to populate columns based on sysdate
############################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo -e "\nBegin Get Parameter: Processing Started at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END

UPDATE storedrft_param 
   SET DAILY_LOAD_RUNDATE = TRUNC(SYSDATE),
       QTLY_1099_RUNDATE = TRUNC(SYSDATE,'Q'),
	   MNTLY_1099_RUNDATE = TRUNC(ADD_MONTHS(SYSDATE,-1),'MM'),
	   JV_MNTLY_RUNDATE = TRUNC(SYSDATE,'MM'),
	   GAINLOSS_MNTLY_RUNDATE = TRUNC(SYSDATE,'MM'),
	   PL_GAIN_RUNDATE = TRUNC(SYSDATE,'MM'),
	   SD_REPORT_QRY_RUNDATE = TRUNC(SYSDATE,'MM'),
	   MID_MNTLY_1099_RUNDATE = TRUNC(ADD_MONTHS(SYSDATE,-1),'MM'),
	   DAILY_PREV_RUNDATE = TRUNC(sysdate-1);
COMMIT;

END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for Get Parameter at $TIME on $DATE"
     exit 1;
fi

echo -e "End Get Parameter: Processing finished at ${TIME} on ${DATE}\n"
############################################################################

exit 0
