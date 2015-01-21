#!/bin/sh
#############################################################################
# Script name : archive_paid_draft_trg_file.sh
#
# Description : This shell program will Archive the Paid_Draft.trg 
#                 file created when JV_monthly_load.sh process is completed.
#
# Created  : 01/20/2015 SXT410 CCN Project Team.....
# Modified :
##############################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

file="ARCHIVE_DRAFT_TRG_FILE"
ARCHIVE_PATH="$HOME/Monthly/jv"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m%d%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $file at $TIME on $DATE"

# Control will output if $DIRECTORY exists.
if [ -d "$ARCHIVE_PATH/"Paid_Draft"_"$DATE"" ]; then
   echo " Directory exists "
else
  mkdir $ARCHIVE_PATH/"Paid_Draft"_"$DATE"
fi

#Archive file for PAID_DRAFT.TRG file.
if 
    ls PAID_DRAFT.TRG &> /dev/null; then
    echo " PAID_DRAFT.TRG file exist "
    find -maxdepth 1 -name PAID_DRAFT.TRG -exec mv {} $ARCHIVE_PATH/"Paid_Draft"_"$DATE"/PAID_DRAFT"_"$TimeStamp.TRG \; > /dev/null 2>&1
else
    echo " PAID_DRAFT.TRG file does not exists "
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $file at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $file at ${TIME} on ${DATE}"  

exit 0
############################################################################