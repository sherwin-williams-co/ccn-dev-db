#!/bin/sh
#################################################################
# Script name   : cc_employee_tax_load.sh
#
# Description   : purpose of this script will be to load CUSTOMER_TAXID_VW table
#
# Created  : 07/30/2014 jxc517 CCN Project Team.....
# Modified : 10/10/2014 jxc517 CCN Project Team.....
#            Modified to get the tax details from synonym in COSTCNTR schema instead of 
#            synonym in STCPR_READ schema
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="cc_employee_tax_load"
LOGDIR=$HOME/dailyLoad/logs
FILE=cc_employee_tax_load_ddl.sql
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
DATE=${DAILY_LOAD_RUNDATE} 
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

if [ -f $FILE ];
then
   echo "File $FILE exists"
   rm -f -r ./$FILE
else
   echo "File $FILE does not exists"
fi

sqlplus -s -l $costcntr_sqlplus_user/$costcntr_sqlplus_pw >> ./$FILE <<END

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CUSTOMER_TAXID_VW_COSTCNTR';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/
CREATE TABLE CUSTOMER_TAXID_VW_COSTCNTR AS SELECT * FROM CUSTOMER_TAXID_VW;
COMMIT;
GRANT SELECT ON COSTCNTR.CUSTOMER_TAXID_VW_COSTCNTR TO STORDRFT;

exit;
END

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END

TRUNCATE TABLE CUSTOMER_TAXID_VW;
INSERT INTO CUSTOMER_TAXID_VW 
    SELECT CUSTNUM,
           NVL(SSN,TAXID),
           PARENT_STORE,
           CUSTNAME,
           DCO_NUMBER
      FROM COSTCNTR.CUSTOMER_TAXID_VW_COSTCNTR;
COMMIT;
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
