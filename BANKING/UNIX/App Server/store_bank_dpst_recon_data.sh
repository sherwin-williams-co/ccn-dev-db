#!/bin/sh
#################################################################
# Script name   : store_bank_dpst_recon_data.sh
# Description   : This shell script is used to execute the stored procedure
#                 BANKING_BATCH_PKG.STORE_BANK_DPST_RECON_DATA to generate last 2 weeks data based on transaction date(STR_BNK_RECNC_DATA_RUN_PERIOD defined in Config file).
#                 If procedure execution fails then send an email with failure text.
# Created       : 03/01/2018 sxg151
# Modified      :
#################################################################
# Setting config variables.
. /app/banking/dev/banking.config


#Read Variables
PROC_NAME="BANKING_BATCH_PKG.STORE_BANK_DPST_RECON_DATA"
LOGDIR=$HOME/logs
THISSCRIPT="store_bank_dpst_recon_dt"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log
EQUAL_VAL=0
SERVER_NAME=$HOSTNAME

touch $LOGDIR/$LOG_NAME

LOGFILEPATH=$LOGDIR/$LOG_NAME

echo "Processing Started for "$PROC_NAME " at "$TIME "on "$DATE >> $LOGDIR/${LOG_NAME}

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<EOF >> $LOGDIR/${LOG_NAME}
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
    :exitCode := 0;
    BANKING_BATCH_PKG.STORE_BANK_DPST_RECON_DATA($STR_BNK_RECNC_DATA_RUN_PERIOD,'$SERVER_NAME','$LOGFILEPATH');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ',' || SQLERRM);
        :exitCode:=2;
END;
/

exit :exitCode
EOF

status=$?
if [ $status -ne $EQUAL_VAL ]
then
    $HOME/send_mail.sh "STORE_BANK_DPST_RECON_DT_ERROR">>$LOGDIR/${LOG_NAME}
    status=$?
    if [ $status -ne $EQUAL_VAL ]
    then
        echo "Mailing process failed for Mail category STORE_BANK_DPST_RECON_DT_ERROR ">>$LOGDIR/${LOG_NAME}
        exit 1
    fi
    exit 1
fi

exit 0