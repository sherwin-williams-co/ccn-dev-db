#!/bin/sh
###########################################################################
# Script name   : chng_inv_indicator.sh
# Description   : DML script for updating INVENTORY_INDICATOR field to 'N'
#    and perp_inv_start_date to NULL in STORE table
#    for COST_CENTER_CODE '778802','779025','768700'
# Created  : 05/18/2017 axt754 CCN Project Team.....
# Modified : 
###########################################################################

. /app/ccn/host.sh

PROC="Change inventory indicator for cost centers 778802,779025,768700"
TIME=`date +"%H%M%S"`
DATE=`date +"%m/%d/%Y"`
LOGFILENAME="$HOME/upd_inv_indicator$TIME.log"

echo "Processing Started for $PROC at $TIME on $DATE" >>$LOGFILENAME

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGFILENAME <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;

UPDATE STORE
   SET INVENTORY_INDICATOR = 'N'
       ,PERP_INV_START_DATE = NULL
 WHERE COST_CENTER_CODE IN ('778802','779025','768700');
COMMIT;
Exception
when others then
 :exitCode:=1;
END;
/

exit :exitCode
EOF

status=$?

############################################################################
#                           ERROR STATUS CHECK 
############################################################################

TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]
then
     echo "processing FAILED for $PROC at $TIME on $DATE" >>$LOGFILENAME
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $PROC at $TIME on $DATE">>$LOGFILENAME

echo "Processing finished for $PROC at $TIME on $DATE and status is $status"
exit 0