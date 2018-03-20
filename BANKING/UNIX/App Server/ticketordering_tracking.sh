#!/bin/sh
###########################################################################################
# Script name   : ticketordering_tracking.sh
# Description   : This shell script is used to execute the stored procedure.
#  If procedure execution succeedes then file will be archived and email will be generated.
#  If procedure execution fails then send an email with failure text.
# Created  : 06/23/2016 mxk766
# Modified : 03/20/2018 sxg151 ASP-575 : Updated Exception section.
###########################################################################################

# Setting config variables.
. /app/banking/dev/banking.config

#Read Variables 

PROC_NAME="DPST_TCKTS_UPDATE_BATCH_PKG.UPDATE_TICKORD_TRACK_NUM"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/datafiles/archieve"
LOGDIR=$HOME/logs
THISSCRIPT="ticketordering_tracking"
TICKETORDER_TRACKING_FILE="ticketordertracking"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"` 
RUN_DATE=`date +"%m/%d/%Y"`
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log
EQUAL_VAL=0

touch $LOGDIR/$LOG_NAME

echo "Processing Started for "$PROC_NAME" at "$TIME "on "$DATE " for run date "$RUN_DATE >> $LOGDIR/${LOG_NAME}

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<EOF >> $LOGDIR/${LOG_NAME}
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
    :exitCode := 0;
    DPST_TCKTS_UPDATE_BATCH_PKG.UPDATE_TICKORD_TRACK_NUM('$RUN_DATE');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ',' || SQLERRM);
        :exitCode:=2;
END;
/
exit :exitCode
EOF

############################################################################
#                           ERROR STATUS CHECK
############################################################################

status=$?

echo "Status code is "$status >> $LOGDIR/${LOG_NAME}

# Checking for the status code. If the status code is 0 then the procedure executed successfully.
# If the procedure fails and the status code is 2 or 3 then an error email is sent.

if [ $status -ne $EQUAL_VAL ]
then
    
    $HOME/send_mail.sh "TICKETORDERTRACKING_ERROR">>$LOGDIR/${LOG_NAME}
    status=$?
    if [ $status -ne $EQUAL_VAL ]
    then
        echo "Mailing process failed for Mail category TICKETORDERTRACKING_ERROR ">>$LOGDIR/${LOG_NAME}
        exit 1
    fi    
    exit 1

else

   #Moving the processed file to archive folder 
   #Create an folder in the archive path for todays date and then move the file into that path.

   if [ -d $ARCHIVE_PATH/${TICKETORDER_TRACKING_FILE}_${DATE} ]
   then
       echo "Direcotry "$ARCHIVE_PATH/${TICKETORDER_TRACKING_FILE}_${DATE} " Exists ">>$LOGDIR/${LOG_NAME}
   else
       echo "Creating directory "$ARCHIVE_PATH/${BAGORDER_TRACKING_FILE}_${DATE}>>$LOGDIR/${LOG_NAME}
       mkdir $ARCHIVE_PATH/${TICKETORDER_TRACKING_FILE}_${DATE}
   fi

   mv $DATA_FILES_PATH/${TICKETORDER_TRACKING_FILE}.txt $ARCHIVE_PATH/${TICKETORDER_TRACKING_FILE}_${DATE}/${TICKETORDER_TRACKING_FILE}_${DATE}_${TIME}.txt
   echo "File moved to archive folder "$ARCHIVE_PATH/${TICKETORDER_TRACKING_FILE}_${DATE} " and renamed "${TICKETORDER_TRACKING_FILE}.txt" to  "${TICKETORDER_TRACKING_FILE}_${DATE}_${TIME}.txt>>$LOGDIR/${LOG_NAME}


fi

echo "Processing finished for "$PROC_NAME" at "$TIME "on "$DATE " for run date "$RUN_DATE >> $LOGDIR/${LOG_NAME}

exit 0

#############################################################################################################################
#                                                   END of PROGRAM.  
#############################################################################################################################