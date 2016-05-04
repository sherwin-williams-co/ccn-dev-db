#!/bin/sh
#################################################################
# Script name   : deposit_tkts_ftp.sh
#
# Description   : this scripts ftp's the deposit ticket files to it's respective server
#
# Created  : 04/04/2016 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_tkts_ftp"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"` 
file1=$1
file2=$2
echo "Processing Started for $proc_name at $TIME on $DATE"

# ftp the files to the Server
cd $HOME
./deposit_tkt_txt_ftp.sh $file1

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if test $status -ne 0
then
   TIME=`date +"%H:%M:%S"`
   echo "processing FAILED for $proc_name while ftping text file at ${TIME} on ${DATE}"
   exit 1;
fi

./deposit_tkt_xml_ftp.sh $file2
############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if test $status -ne 0
then
   TIME=`date +"%H:%M:%S"`
   echo "processing FAILED for $proc_name while ftping xml file at ${TIME} on ${DATE}"
   exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
############################################################################