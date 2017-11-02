#!/bin/sh
########################################################################################################################
# Script name   : Load_member_bank_concentration_cc.sh
#
# Description   : This shell program will execute a SQL script to load the data in MEMBER_BANK_CONCENTRATION_CC table.
#                 
#                 
# Created       : 10/31/2017 sxg151 CCN Project Team
# 
#                  
########################################################################################################################
. /app/banking/dev/banking.config

#Read Variables
PROC_NAME="BANKING_BATCH_PKG.LOAD_MEMER_BANK_CONCENT_CC"
LOGDIR=$HOME/logs
THISSCRIPT="Load_member_bank_concentration_cc"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"` 
INPUT_DATE=`date +"%d-%b-%y"`
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
DELETE  FROM MEMBER_BANK_CONCENTRATION_CC WHERE LOAD_DATE = '$INPUT_DATE';
commit;
BANKING_BATCH_PKG.LOAD_MEMER_BANK_CONCENT_CC('$INPUT_DATE');
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

    $HOME/send_mail.sh "LOAD_MEMER_BANK_CONCENT_CC_ERROR">>$LOGDIR/${LOG_NAME}
    status=$?
    if [ $status -ne $EQUAL_VAL ]
    then
        echo "Mailing process failed for Mail category LOAD_MEMER_BANK_CONCENT_CC_ERROR ">>$LOGDIR/${LOG_NAME}
        exit 1
    fi
exit 1
else

    $HOME/send_mail.sh "LOAD_MEMER_BANK_CONCENT_CC_COMPLETE">>$LOGDIR/${LOG_NAME}
    status=$?

    if [ $status -ne $EQUAL_VAL ]
    then

        echo "Mailing process failed for Mail category LOAD_MEMER_BANK_CONCENT_CC_ERROR ">>$LOGDIR/${LOG_NAME}
        exit 1
    fi
fi

exit 0

######################################################################################################################