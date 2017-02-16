#!/bin/sh
#################################################################
# Script name   : terr_init_load.sh
# Description   : This shell script is used to call the initload 
#                 processing for territory data
# Created  : 02/05/2017 MXK766 CCN Project ....
# Modified : 
#################################################################
. /app/ccn/host.sh


proc_name="terr_init_load.sh";

TIME=`date +"%H%M%S"`
DATE=`date +"%m%d%Y"`
LOGFILE=terr_init_load_"$DATE"_"$TIME".log
LOGDIR="$HOME/datafiles/log"
touch $LOGDIR/$LOGFILE

echo "Processing Started for $proc_name at $TIME on $DATE"  > $LOGDIR/$LOGFILE

sqlplus -s -l $sqlplus_user/$sqlplus_pw >>$LOGDIR/$LOGFILE <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
DECLARE
V_POS_DOWNLOADS CCN_UTILITY.POS_DOWNLOADS%ROWTYPE;
BEGIN
:exitCode := 0;
POS_DATA_GENERATION.INIT_LOAD_TERR_SP;
Exception
when others then
:exitCode:=1;
END;
/

exit :exitCode
EOF

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ];
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED while executing $proc_name "
    ./send_mail.sh ARCHIVINGPROCESSFAILURE "Initial Load for territory failed. Please check the log file $LOGDIR/$LOGFILE"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name for file name $FILENAME" >>$LOGDIR/$LOGFILE 
exit 0
############################################################################