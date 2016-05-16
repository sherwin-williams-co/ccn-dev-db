#!/bin/sh

##########################################################################################
#
# This is an adhoc script to udpate polling status over the weekend, one time run
#
# Date Created: 02/28/2014 JXC517
# Date Updated: 
#
##########################################################################################

echo "\n begin bulk_hier_load.sh script"

# link to parameter file
. /app/ccn/ccn.config

# establish the date and time
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`
PROC="adhoc_polling_status_update.sh"

ORACLE_HOME=/swstores/oracle/stcprp/product/11g
export ORACLE_HOME

ORACLE_SID=STCPRP1
export ORACLE_SID

PATH=$PATH:$ORACLE_HOME/bin 
export PATH

echo "\nProcessing Started for $PROC at $TIME on $DATE"
$ORACLE_HOME/bin/sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;

DECLARE
    V_XML                  VARCHAR2(32000);
    V_PREV_POLLING_STATUS  VARCHAR2(1);
    
FUNCTION BUILD_TAG(IN_VALUE     IN VARCHAR2,
                   IN_TAG_NAME  IN VARCHAR2,
                   IN_DATE_FLAG IN VARCHAR2 DEFAULT 'N') RETURN VARCHAR2 IS
   V_VALUE VARCHAR2(10000);
BEGIN
      IF IN_VALUE IS NULL THEN
         RETURN '<' || IN_TAG_NAME || '/>';
      END IF;
      IF IN_DATE_FLAG = 'N' THEN
         RETURN '<' || IN_TAG_NAME || '>' || TRIM(IN_VALUE) || '</' || IN_TAG_NAME || '>';
      ELSE
         RETURN '<' || IN_TAG_NAME || '>' || TO_CHAR(TO_DATE(TRIM(IN_VALUE),'RRRRMMDD'),'MM-DD-RRRR') || '</' || IN_TAG_NAME || '>';
      END IF;
END BUILD_TAG;

BEGIN

    CCN_BATCH_PKG.LOCK_DATABASE_SP();

    FOR rec IN (SELECT * FROM COST_CENTER_POLLING WHERE POLLING_STATUS IS NOT NULL) LOOP
        V_XML                 := NULL;
        V_PREV_POLLING_STATUS := NULL;
        V_XML := '<?xml version="1.0" encoding="UTF-8"?>'||
                 '<POLLING_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">';
        FOR polling_rec IN (SELECT *
                              FROM POLLING
                             WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE
                               AND CURRENT_FLAG     = 'Y') LOOP
            V_PREV_POLLING_STATUS := polling_rec.POLLING_STATUS_CODE;
            V_XML := V_XML || '<POLLING>';
            V_XML := V_XML || BUILD_TAG(polling_rec.COST_CENTER_CODE,'COST_CENTER_CODE');
            V_XML := V_XML || BUILD_TAG(rec.POLLING_STATUS,'POLLING_STATUS_CODE');
            V_XML := V_XML || BUILD_TAG(polling_rec.MULTICAST_IND,'MULTICAST_IND');
            V_XML := V_XML || BUILD_TAG(polling_rec.TIME_ZONE,'TIME_ZONE');
            V_XML := V_XML || BUILD_TAG(polling_rec.POLLING_IND,'POLLING_IND');
            V_XML := V_XML || BUILD_TAG(polling_rec.NEXT_DOWNLOAD_BLOCK_COUNT,'NEXT_DOWNLOAD_BLOCK_COUNT');
            V_XML := V_XML || BUILD_TAG(polling_rec.CURRENT_FLAG,'CURRENT_FLAG');
            V_XML := V_XML || '</POLLING>';
        END LOOP;
        FOR bankcard_rec IN (SELECT *
                              FROM BANK_CARD
                             WHERE COST_CENTER_CODE    = rec.COST_CENTER_CODE
                               AND POLLING_STATUS_CODE = V_PREV_POLLING_STATUS
                               AND EXPIRATION_DATE IS NULL) LOOP
            V_XML := V_XML || '<BANK_CARD>';
            V_XML := V_XML || BUILD_TAG(bankcard_rec.COST_CENTER_CODE,'COST_CENTER_CODE');
            V_XML := V_XML || BUILD_TAG(rec.POLLING_STATUS,'POLLING_STATUS_CODE');
            V_XML := V_XML || BUILD_TAG(bankcard_rec.MERCHANT_ID,'MERCHANT_ID');
            V_XML := V_XML || BUILD_TAG(rec.OPEN_DATE,'EFFECTIVE_DATE','Y');
            V_XML := V_XML || BUILD_TAG(bankcard_rec.EXPIRATION_DATE,'EXPIRATION_DATE','Y');
            V_XML := V_XML || BUILD_TAG(TO_CHAR(bankcard_rec.LAST_MAINT_DATE, 'RRRRMMDD'),'LAST_MAINT_DATE','Y');
            V_XML := V_XML || BUILD_TAG(bankcard_rec.LAST_MAINT_METHOD_ID,'LAST_MAINT_METHOD_ID');
            V_XML := V_XML || BUILD_TAG(bankcard_rec.LAST_MAINT_USER_ID,'LAST_MAINT_USER_ID');
            V_XML := V_XML || BUILD_TAG(bankcard_rec.QUALITY_CODE,'QUALITY_CODE');
            V_XML := V_XML || BUILD_TAG(bankcard_rec.AMEX_SE_ID,'AMEX_SE_ID');
            V_XML := V_XML || BUILD_TAG(bankcard_rec.DISCOVER_ID,'DISCOVER_ID');
            V_XML := V_XML || '</BANK_CARD>';
        END LOOP;
        V_XML := V_XML || '<TERMINAL_TABLE>';
        FOR terminal_rec IN (SELECT *
                              FROM TERMINAL
                             WHERE COST_CENTER_CODE    = rec.COST_CENTER_CODE
                               AND POLLING_STATUS_CODE = V_PREV_POLLING_STATUS
                               AND EXPIRATION_DATE IS NULL) LOOP
            V_XML := V_XML || '<TERMINAL>';
            V_XML := V_XML || BUILD_TAG(terminal_rec.COST_CENTER_CODE,'COST_CENTER_CODE');
            V_XML := V_XML || BUILD_TAG(rec.POLLING_STATUS,'POLLING_STATUS_CODE');
            V_XML := V_XML || BUILD_TAG(terminal_rec.TERMINAL_NUMBER,'TERMINAL_NUMBER');
            V_XML := V_XML || BUILD_TAG(TO_CHAR(terminal_rec.EFFECTIVE_DATE, 'RRRRMMDD'),'EFFECTIVE_DATE','Y');
            V_XML := V_XML || BUILD_TAG(terminal_rec.EXPIRATION_DATE,'EXPIRATION_DATE','Y');
            V_XML := V_XML || BUILD_TAG(TO_CHAR(terminal_rec.POS_LAST_TRAN_DATE, 'RRRRMMDD'),'POS_LAST_TRAN_DATE','Y');
            V_XML := V_XML || BUILD_TAG(terminal_rec.POS_LAST_TRAN_NUMBER,'POS_LAST_TRAN_NUMBER');
            V_XML := V_XML || '</TERMINAL>';
        END LOOP;
        V_XML := V_XML || '</TERMINAL_TABLE>';
        V_XML := V_XML || '</POLLING_UI>';
        --DBMS_OUTPUT.PUT_LINE(V_XML);
        BEGIN
            CCN_UI_INTERFACE_APP_PKG.POLLING_UI_UPSERT_SP(V_XML);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE('Error : ' || SQLCODE || SQLERRM);
        END;
    END LOOP;

    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();

END;
/
 
exit;
END

echo "\n return from $PROC \n"

##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "\n processing of $PROC failed at ${TIME} on ${DATE}"
     exit 1;
else
   echo "\n processing of $PROC completed successfully at ${TIME} on ${DATE}"
fi

echo "\n ending bulk_hier_load.sh script \n"

##############################
#  end of script             #
##############################
