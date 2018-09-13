#!/bin/sh

##########################################################################################
# Script Name   :  generate_ccn_phone_info_rpt.sh
# purpose of this script will be to generate phone details report and FTP to server
#  and perform the following steps:
# 1. establish connection to SQLPLUS
# 2. Execute GENERATE_CCN_PHONE_INFO_RPT procedure to get report
#    and load to xlsx  file
# 3. FTP the generated file to destination server
# 4. Archive the file after FTP completed
#
# Date Created: 08/23/2018 kxm302
# Date Updated: 
#
##########################################################################################
# Change directory to home path
cd /app/ccn/dev

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="GENERATE_CCN_PHONE_INFO_RPT"
 LOGDIR="$HOME/datafiles/log"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc  at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<EOF
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
    :exitCode := 0;
    CCN_BATCH_PROCESS.GENERATE_CCN_PHONE_INFO_RPT();
EXCEPTION
WHEN OTHERS THEN
    :exitCode := 2;
END;
/
exit :exitCode
EOF
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  
############################################################################


############################################################################
#                           FTP TO SERVER 
############################################################################

echo "FTP to Server Started" >> $LOGDIR/$proc"_"$TimeStamp.log
src_file_path="$HOME/datafiles/CCN_PHONE_INFO*.xlsx"
des_file_name=`ls -lrt $HOME/datafiles/CCN_PHONE_INFO*.xlsx | rev | cut -d'/' -f1|rev`

ftpResult=`ftp -n $ccn_phone_host <<FTP_MF
quote USER $ccn_phone_user
quote PASS $ccn_phone_pw
put $src_file_path $des_file_path/$des_file_name
bye
FTP_MF`
echo "FTP to Server COMPLETED" >> $LOGDIR/$proc"_"$TimeStamp.log

############################################################################

############################################################################
#                           ARCHIVE PROCESS 
############################################################################

status=$?
if test $status -ne 0
then
     echo "FTP processing FAILED " >> $LOGDIR/$proc"_"$TimeStamp.log
     exit 1;

fi

echo "Starting archiving the FTP file" >> $LOGDIR/$proc"_"$TimeStamp.log

mv -f $src_file_path $HOME/archive
echo "The archive file processing completed successfully" >> $LOGDIR/$proc"_"$TimeStamp.log
exit 0;

############################################################################

