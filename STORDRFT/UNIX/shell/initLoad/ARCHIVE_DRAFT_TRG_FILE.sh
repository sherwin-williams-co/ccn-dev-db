#!/bin/sh
#######################################################################################
# Script name   : ARCHIVE_DRAFT_TRG_FILE
#
# Description   : This shell program will Archive the INSPAYMENT.trg 
#                 file created when the gainloss_jv process is completed
# Created  : 01/20/2015 AXK326 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : AXK326 10/12/2015 changed name to INSPAYMENT.TRG 
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
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo " processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo " Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
