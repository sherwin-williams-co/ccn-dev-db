#!/bin/sh
#############################################################################
# Script name : archive_paid_draft_trg_file.sh
#
# Description : This shell program will Archive the Paid_Draft.trg 
#                 file created when JV_monthly_load.sh process is completed.
#
# Created  : 01/20/2015 SXT410 CCN Project Team.....
# Modified : 02/04/2015 sxt410 Changed trigger file name from PAID_DRAFT.TRG to DRAFT.TRG
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
##############################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

file="ARCHIVE_DRAFT_TRG_FILE"
ARCHIVE_PATH="$HOME/Monthly/jv"
TIME=`date +"%H:%M:%S"`
DATE=`date -d ${JV_MNTLY_RUNDATE} +"%m%d%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $file at $TIME on $DATE"

# Control will output if $DIRECTORY exists.
if [ -d "$ARCHIVE_PATH/"Draft"_"$DATE"" ]; then
   echo " Directory exists "
else
  mkdir $ARCHIVE_PATH/"Draft"_"$DATE"
fi

#Archive file for DRAFT.TRG file.
if 
    ls DRAFT.TRG &> /dev/null; then
    echo " DRAFT.TRG file exist "
    find -maxdepth 1 -name DRAFT.TRG -exec mv {} $ARCHIVE_PATH/"Draft"_"$DATE"/DRAFT"_"$TimeStamp.TRG \; > /dev/null 2>&1
else
    echo " DRAFT.TRG file does not exists "
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $file at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $file at ${TIME} on ${DATE}"  

exit 0
############################################################################
