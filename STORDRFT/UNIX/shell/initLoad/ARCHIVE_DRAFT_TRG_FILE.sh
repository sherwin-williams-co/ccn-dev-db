#!/bin/sh
#######################################################################################
# Script name   : ARCHIVE_DRAFT_TRG_FILE
#
# Description   : This shell program will Archive the INSPAYMENT.trg 
#                 file created when the gainloss_jv process is completed
# Created  : 01/20/2015 AXK326 CCN Project Team.....
# Modified : 04/27/2015 AXK326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : AXK326 02/03/2015 Originally modified Trigger file name from DRAFT.TRG to INSPAYMENT.TRG in Production Environment
#          : AXK326 10/12/2015 changed name to INSPAYMENT.TRG as a new request
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#######################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="ARCHIVE_DRAFT_TRG_FILE"
ARCHIVE_PATH="$HOME/Monthly/jv"
TIME=`date +"%H:%M:%S"`
DATE=`date -d ${GAINLOSS_MNTLY_RUNDATE} +"%m%d%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo " Processing Started for $proc_name at $TIME on $DATE"

# Control will output if $DIRECTORY exists.
if [ -d "$ARCHIVE_PATH/"INSPAYMENT"_"$DATE"" ]; then
   echo " Directory exists "
else
  mkdir $ARCHIVE_PATH/"INSPAYMENT"_"$DATE"
fi

#Archive file for INSPAYMENT.TRG file.
if 
    ls INSPAYMENT.TRG &> /dev/null; then
    echo " INSPAYMENT.TRG file exist "
    find -maxdepth 1 -name INSPAYMENT.TRG -exec mv {} $ARCHIVE_PATH/"INSPAYMENT"_"$DATE"/INSPAYMENT"_"$TimeStamp.TRG \; > /dev/null 2>&1
else
    echo " INSPAYMENT.TRG file does not exists "
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo " processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo " Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
