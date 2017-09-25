#!/bin/sh
#################################################################
# Script name   : SRA11000_get_input_files.sh
#
# Description   : This shell script will use FTP to get the input files
#
# Created  : 04/18/2017 jxc517 CCN Project Team.....
# Modified : 08/14/2017 nxk927 CCN Project Team.....
#            changed the variable name in the config file
# Modified : 09/25/2017 nxk927 CCN Project Team.....
#            getting the files to ccn_users folder
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_get_input_files"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#         FTP files stores_cashflowadj_*
#################################################################
echo "Processing started for FTP at ${TIME} on ${DATE}"

cd /app/banking/dev/datafiles/ccn_users
ftp -inv ${smart_host} <<FTP_MF
quote user ${smart_user}
quote pass ${smart_pw}
cd "/sw/smart_adm/loads/ach/data/ach"
pwd
SITE BLKSIZE(9400) LRECL(94) RECFM(FB) CYLINDER SPACE(1,1)
get stores_ach.txt
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF

status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
