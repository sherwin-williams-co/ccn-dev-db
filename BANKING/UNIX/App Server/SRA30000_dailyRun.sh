#!/bin/sh
#################################################################
# Script name   : SRA30000_dailyRun.sh
#
# Description   : This is the main script for SRA30000 process
#
# Created  : 10/31/2016 vxv336 CCN Project Team
# Modified : 12/08/2016 vxv336 Added POS file generation and Diff
#
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA30000_dailyRun"
TIME=`date +"%H:%M:%S"`
YYMMDD=`date +"%y%m%d"`

echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#         Generate file from POS and Send Diff
#################################################################
cd $HOME/initLoad
cp SRA30000_D$YYMMDD* GIFT_CARD_POS_TRANS_file.TXT

cd $HOME
./pos_gift_card_file_diff.sh
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for pos_gift_card_file_diff at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for pos_gift_card_file_diff at ${TIME} on ${DATE}"

#################################################################
#         FTP mainframe output file
#################################################################
./SRA30000_dailyRun_ftp.sh
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for SRA30000_dailyRun_ftp at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA30000_dailyRun_ftp at ${TIME} on ${DATE}"

#################################################################
#         ARCHIVE mainframe output file
#################################################################
./SRA30000_Arch_Output_file.sh
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for SRA30000_Arch_Output_file script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA30000_Arch_Output_file script at ${TIME} on ${DATE}"

exit 0