#!/bin/sh
#################################################################
# Script name   : bagordering_tracking.sh
# Description   : This shell script is used to execute the stored procedure.
#  If procedure execution succeedes then file will be archived and email will be generated.
#  If procedure execution fails then send an email with failure text.
# Created  : 06/23/2016 mxk766
# Modified : 
#################################################################

# Setting config variables.

. /app/banking/dev/banking.config


#Read Variables 

PROC_NAME="DPST_BAGS_UPDATE_BATCH_PKG.UPDATE_BAGORDER_TRACK_NUM"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/datafiles/archieve"
LOGDIR=$HOME/logs
THISSCRIPT="bagordering_tracking"
BAGORDER_TRACKING_FILE="bagordertracking"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"` 
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log
EQUAL_VAL=0

#The below variable is populated from the bank_batch_date config file.
RUN_DATE=$BAG_TRACKING_RUNDATE

#echo $RUN_DATE 

touch $LOGDIR/$LOG_NAME

echo "Processing Started for "$PROC_NAME " at "$TIME "on "$DATE " for run date "$RUN_DATE >> $LOGDIR/${LOG_NAME}

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<EOF >> $LOGDIR/${LOG_NAME}
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
DPST_BAGS_UPDATE_BATCH_PKG.UPDATE_BAGORDER_TRACK_NUM('$RUN_DATE');
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
    $HOME/send_mail.sh "BAGORDERTRACKING_ERROR">>$LOGDIR/${LOG_NAME}
    status=$?
    if [ $status -ne $EQUAL_VAL ]
    then
        echo "Mailing process failed for Mail category BAGORDERTRACKING_ERROR ">>$LOGDIR/${LOG_NAME}
        exit 1
    fi
exit 1
else
    #Moving the processed file to archive folder first before sending the success message.
    #This is done to make sure that we do not reprocess the same file again in case if the success email fails.
    
    if [ -d $ARCHIVE_PATH/${BAGORDER_TRACKING_FILE}_${DATE} ]
    then
        echo "Direcotry "$ARCHIVE_PATH/${BAGORDER_TRACKING_FILE}_${DATE} " Exists ">>$LOGDIR/${LOG_NAME}
    else
        echo "Creating directory "$ARCHIVE_PATH/${BAGORDER_TRACKING_FILE}_${DATE}>>$LOGDIR/${LOG_NAME}
        mkdir $ARCHIVE_PATH/${BAGORDER_TRACKING_FILE}_${DATE}
    fi

    mv $DATA_FILES_PATH/${BAGORDER_TRACKING_FILE}.txt $ARCHIVE_PATH/${BAGORDER_TRACKING_FILE}_${DATE}/${BAGORDER_TRACKING_FILE}_${DATE}_${TIME}.txt
    echo "File moved to archive folder "$ARCHIVE_PATH/${BAGORDER_TRACKING_FILE}_${DATE} " and renamed "${BAGORDER_TRACKING_FILE}.txt" to  "${BAGORDER_TRACKING_FILE}_${DATE}_${TIME}.txt>>$LOGDIR/${LOG_NAME}

    $HOME/send_mail.sh "BAGORDER_PROCESS_COMPLETE">>$LOGDIR/${LOG_NAME}
    status=$?

    if [ $status -ne $EQUAL_VAL ]
    then
        echo "Mailing process failed for Mail category BAGORDER_PROCESS_COMPLETE ">>$LOGDIR/${LOG_NAME}
        exit 1
    fi
fi

exit 0