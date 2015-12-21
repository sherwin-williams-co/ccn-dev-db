#!/bin/sh -e
#################################################################################################################################
# Script name   : ccn_vendor_details_sync.sh
#
# Description   : purpose of this script will be to load VENDOR_INFO table from
#                 SWC_AP_SUPPLIER_INFO_V external source
#
# Created  : 06/29/2015 jxc517 CCN Project Team.....
# Modified : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
#################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="ccn_vendor_details_sync"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
EXECUTE IMMEDIATE 'TRUNCATE TABLE VENDOR_INFO';
INSERT INTO VENDOR_INFO
    SELECT REPLACE(SUPPLIER_NUM_1099,'-') TAX_ID,
           SITE_ATTRIBUTE3 VENDOR_NO,
           SUPPLIER_NAME VENDOR_NAME,
           SITE_LAST_UPDATE_DATE
      FROM SWC_AP_SUPPLIER_INFO_V
     WHERE SUPPLIER_VENDOR_TYPE_LOOKUP IN ('INSTALLER','SUBCONTRACTOR')
       AND SITE_INACTIVE_DATE IS NULL
       AND SUPPLIER_END_DATE_ACTIVE IS NULL
       AND SITE_ATTRIBUTE3 IS NOT NULL
       AND SUPPLIER_NUM_1099 IS NOT NULL;
COMMIT;
Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
if [ 0 -ne "$?" ]; then
    echo "ccn_vendor_details_sync process blew up." 
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
 MAIL_PKG.send_mail('VENDOR_DETAILS_SYNC_ERROR');
 Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
if [ 0 -ne "$?" ]; then
echo "VENDOR_DETAILS_SYNC_ERROR - send_mail process blew up." 
else
echo "Successfully sent mail for the errors"
fi
exit 1
fi	
exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
