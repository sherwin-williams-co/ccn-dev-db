#!/bin/sh
#################################################################
# Script name   : ARCHIVE_DRAFT_TRG_FILE
#
# Description   : This shell program will Archive the draft.trg 
#                 file created when the gainloss_jv process is completed
# Created  : 01/20/2015 AXK326 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="ARCHIVE_DRAFT_TRG_FILE"
ARCHIVE_PATH="$HOME/Monthly/jv"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m%d%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

# Control will output if $DIRECTORY exists.
if [ -d "$ARCHIVE_PATH/"Draft"_"$DATE"" ]; then
   echo " Directory exists "
else
  mkdir $ARCHIVE_PATH/"Draft"_"$DATE"
fi

#Archive file for Draft.TRG file.
if 
    ls DRAFT.TRG &> /dev/null; then
    echo " DRAFT.TRG file exist "
    find -maxdepth 1 -name DRAFT.TRG -exec mv {} $ARCHIVE_PATH/"Draft"_"$DATE"/DRAFT"_"$TimeStamp.TRG \; > /dev/null 2>&1
else
    echo " Draft.TRG file does not exists "
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
