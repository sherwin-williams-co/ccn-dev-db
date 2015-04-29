#!/bin/sh
#######################################################################################
# Script name   : ARCHIVE_DRAFT_TRG_FILE
#
# Description   : This shell program will Archive the draft.trg 
#                 file created when the gainloss_jv process is completed
# Created  : 01/20/2015 AXK326 CCN Project Team.....
# Modified : 04/28/2015 AXK326 CCN Project Team.....
#            Added parameter to pick up the date value from the config file P1, P2, TimeStamp
#######################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="ARCHIVE_DRAFT_TRG_FILE"
ARCHIVE_PATH="$HOME/Monthly/jv"
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
P1=${GAINLOSS_MNTLY_RUNDATE}
P2=`date -d $P1 +"%m%d%Y"`
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME 
echo " Processing Started for $proc_name at $TIME for the date $P1"

# Control will output if $DIRECTORY exists.
if [ -d "$ARCHIVE_PATH/"Draft"_"$P2"" ]; then
   echo " Directory exists "
else
  mkdir $ARCHIVE_PATH/"Draft"_"$P2"
fi

#Archive file for Draft.TRG file.
if 
    ls DRAFT.TRG &> /dev/null; then
    echo " DRAFT.TRG file exist "
    find -maxdepth 1 -name DRAFT.TRG -exec mv {} $ARCHIVE_PATH/"Draft"_"$P2"/DRAFT"_"$TimeStamp.TRG \; > /dev/null 2>&1
else
    echo " Draft.TRG file does not exists "
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${GAINLOSS_MNTLY_RUNDATE}
status=$?
if test $status -ne 0
then
     echo " processing FAILED for $proc_name at ${TIME} for the date ${P1}"
     exit 1;
fi

echo " Processing finished for $proc_name at ${TIME} for the date ${P1}"  

exit 0
############################################################################
