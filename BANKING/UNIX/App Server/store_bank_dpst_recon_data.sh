#!/bin/sh
#################################################################
# Script name   : store_bank_dpst_recon_data.sh
# Description   : This shell script is used to execute the stored procedure 
#                 BANKING_BATCH_PKG.STORE_BANK_DPST_RECON_DATA.
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
DECLARE
V_RUN_PERIOD PLS_INTEGER:=14;
BEGIN
:exitCode := 0;
BANKING_BATCH_PKG.STORE_BANK_DPST_RECON_DATA(V_RUN_PERIOD,'$SERVER_NAME','$LOGFILEPATH');
Exception
when others then
if sqlcode = -20001 then
:exitCode:=2;
else
:exitCode:=3;
end if;
END;
/

exit :exitCode
EOF

status=$?

echo "Status code is "$status >> $LOGDIR/${LOG_NAME}

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
else

    $HOME/send_mail.sh "STORE_BANK_DPST_RECON_DT_COMPLETE">>$LOGDIR/${LOG_NAME}
    status=$?

    if [ $status -ne $EQUAL_VAL ]
    then

        echo "Mailing process failed for Mail category STORE_BANK_DPST_RECON_DT_ERROR ">>$LOGDIR/${LOG_NAME}
        exit 1
    fi
fi

exit 0