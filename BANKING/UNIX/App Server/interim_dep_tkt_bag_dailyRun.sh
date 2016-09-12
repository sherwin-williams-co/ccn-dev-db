#!/bin/sh
#################################################################
# Script name   : interim_dep_tkt_bag_dailyRun.sh
#                 This script should be executed before our daily batch run (dep_tkt_bag_dailyRun.sh) for the deposit tickets and bag.
#
# Description   : This shell script will perform below tasks
#                 1. rename the files accordingly
#                 2. invoke the procedure that performs the core process
#                 3. archieve the files in it's corresponding folder
#
# Created  : 09/09/2016 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="interim_dep_tkt_bag_dailyRun"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/initLoad/archieve/DEP_TKT_BAG"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
FOLDER=`date +"%m%d%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#          Control will output if directory with that date exists
#################################################################
if [ -d "$ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $ARCHIVE_PATH/$FOLDER
fi

#################################################################
#                                          Rename the input files
#################################################################
TIME=`date +"%H:%M:%S"`
echo "Processing Started for Renaming deposit files at $TIME on $DATE"
if [ -f $DATA_FILES_PATH/STE03064_DEPST_D*.TXT ] 
then
    echo "$DATA_FILES_PATH/STE03064_DEPST_D*.TXT files exist to rename"
    cat $DATA_FILES_PATH/STE03064_DEPST_D*.TXT >> $DATA_FILES_PATH/STE03064_DEPST.TXT
else
    echo "$DATA_FILES_PATH/STE03064_DEPST_D*.TXT files does not exist to rename"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for Renaming deposit files at ${TIME} on ${DATE}"


#################################################################
#                  DPST_TCKTS_UPDATE_BATCH_PKG.INTRM_DPST_TKT_PROCESS
#                  DPST_BAGS_UPDATE_BATCH_PKG.INTRM_DPST_BAG_PROCESS
#################################################################
echo "Processing started for Interim Dep tickets and bags batch process at ${TIME} on ${DATE}"
LOGNAME=$proc_name"_"$TimeStamp.log
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$LOGNAME <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
DPST_TCKTS_UPDATE_BATCH_PKG.INTRM_DPST_TKT_PROCESS('$HOSTNAME','$LOGDIR/$LOGNAME');
DPST_BAGS_UPDATE_BATCH_PKG.INTRM_DPST_BAG_PROCESS('$HOSTNAME','$LOGDIR/$LOGNAME');

Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for Interim Dep tickets and bags batch process at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for Interim Dep tickets and bags batch process at ${TIME} on ${DATE}"

#################################################################
#                                       Archive files to folder
#################################################################
TIME=`date +"%H:%M:%S"`
echo "Processing Started for archiving the files at $TIME on $DATE"
if [ -f $DATA_FILES_PATH/STE03064_DEPST.TXT ]
then
    echo "$DATA_FILES_PATH/STE03064_DEPST.TXT files exist to rename"
    mv $DATA_FILES_PATH/STE03064_DEPST*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/STE03064_DEPST.TXT files does not exist"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for archiving the files at ${TIME} on ${DATE}"

#################################################################
#                                              Process complete
#################################################################
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

