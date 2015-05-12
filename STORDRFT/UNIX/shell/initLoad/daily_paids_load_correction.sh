#!/bin/sh
#################################################################
# Script name   : daily_paids_load_correction.sh
#
# Description   : This shell program will correct the royal paid errors
#
# Created  : 12/08/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="daily_paids_load_correction"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc at $TIME on $DATE"

find $HOME/dailyLoad/archieve/drafts -name STBD0601_ROYALBNK_PAID2.TXT -print0 | xargs -0 -I file cat file > $HOME/initLoad/STBD0601_ROYALBNK_PAID2.TXT

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('SD_DAILY_PAIDS_LOAD_START');

DECLARE
    
    CURSOR TEMP_CUR is
        SELECT CCN_COMMON_TOOLS.GET_DATE_VALUE('1'||PAID_DATE, 'YYMMDD') PAID_DATE,
               CCN_COMMON_TOOLS.RETURN_NUMBER(AMOUNT,11,2) AMOUNT,
               FILLER||CHECK_NUMBER_CC||CHECK_NUMBER_SQ||CHECK_NUMBER_CK CHECK_SERIAL_NUMBER
          FROM TEMP_PAID_DETAILS_ROYAL;

    V_COMMIT     NUMBER := 0;
    V_TEMP_ROW   STORE_DRAFTS%ROWTYPE;
    V_CONTEXT    VARCHAR2(200);
    V_START_TIME NUMBER;
    V_START_DURATION DATE := SYSDATE;
    V_CLOB       CLOB;
    
V_BATCH_NUMBER      BATCH_JOB.BATCH_JOB_NUMBER%TYPE;
V_TRANS_STATUS      BATCH_JOB.TRANS_STATUS%TYPE := 'SUCCESSFUL';
BEGIN
    CCN_BATCH_PKG.INSERT_BATCH_JOB('SD_DAILY_PAID_LOAD', V_BATCH_NUMBER);
    CCN_BATCH_PKG.LOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Update STORE_DRAFTS paid details ';

    FOR rec IN TEMP_CUR LOOP
        BEGIN
            BEGIN
                SELECT *
                  INTO V_TEMP_ROW
                  FROM STORE_DRAFTS
                 WHERE CHECK_SERIAL_NUMBER = CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CHECK_SERIAL_NUMBER);

                V_TEMP_ROW.PAID_DATE           := rec.PAID_DATE;
                V_TEMP_ROW.BANK_PAID_AMOUNT    := rec.AMOUNT;
                SD_BUSINESS_RULES_PKG.SET_STORE_DRAFT_FLAGS(V_TEMP_ROW);
            EXCEPTION
                WHEN OTHERS THEN
                    V_TEMP_ROW := NULL;
            END;

            IF V_TEMP_ROW.CHECK_SERIAL_NUMBER IS NOT NULL AND V_TEMP_ROW.PAID_DATE IS NOT NULL THEN
                UPDATE STORE_DRAFTS
                   SET ROW = V_TEMP_ROW
                 WHERE CHECK_SERIAL_NUMBER = V_TEMP_ROW.CHECK_SERIAL_NUMBER;
            ELSE
                ERRPKG.INSERT_ERROR_LOG_SP(200,
                                           'LOAD_SUNTRUST_PAID_DETAILS',
                                           'Check Serial Number (or) Paid Date is null',
                                           NULL, --cost_center_code
                                           NVL(rec.CHECK_SERIAL_NUMBER,''));
            END IF;

            V_TEMP_ROW := NULL ;
            V_COMMIT := V_COMMIT + 1;
            IF V_COMMIT > 500 THEN
                COMMIT;
                V_COMMIT := 0;
            END IF;   
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_SUNTRUST_PAID_DETAILS',
                                           SQLERRM,
                                           NULL, --cost_center_code
                                           NVL(rec.CHECK_SERIAL_NUMBER,''));
        END;
    END LOOP;
    COMMIT;
    dbms_output.put_line('STORE_DRAFTS paid details updated in : '|| (dbms_utility.get_time - v_start_time)/100 || ' Seconds');

      FOR rec IN (SELECT * FROM ERROR_LOG WHERE ERROR_DATE >= V_START_DURATION) LOOP
          V_CLOB := V_CLOB || rec.COST_CENTER ||','|| rec.ERROR_TEXT || CHR(10);
      END LOOP;
      IF V_CLOB <> EMPTY_CLOB() THEN
          MAIL_PKG.SEND_MAIL('SD_PAIDS_LOAD_ERRORS',NULL, NULL, V_CLOB);
      END IF;
    EXCEPTION
        WHEN OTHERS THEN
            V_TRANS_STATUS := 'ERROR';
    END;
    
    CCN_BATCH_PKG.UPDATE_BATCH_JOB('SD_DAILY_PAID_LOAD', V_BATCH_NUMBER, V_TRANS_STATUS);
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION; 
EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'CCN_SD_PAID_LOAD_SP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000'); 
END;
/

execute MAIL_PKG.send_mail('SD_DAILY_PAIDS_LOAD_END');

exit;
END

echo "removing the one time concatenated file"
rm -f $HOME/initLoad/STBD0601_ROYALBNK_PAID2.TXT

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
