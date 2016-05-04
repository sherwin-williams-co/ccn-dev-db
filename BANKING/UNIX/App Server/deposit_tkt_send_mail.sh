#!/bin/sh
#################################################################
# Script name   : deposit_tkt_send_mail.sh
#
# Description   : this scripts will send the email to let the user know that the deposit ticket 
#                 has been created but before we send that file, the already present file has to be processed
#
# Created  : 04/04/2016 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_tkt_send_mail"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"` 
filename=$1

echo "Processing Started for $proc_name at $TIME on $DATE"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('DEPOSIT_TICKET_FILE',null,'$filename'); 
Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for Sending Mail at ${TIME} on ${DATE}"
    exit 1;
fi

echo $filename "file already exists. Check the file for processing first"

############################################################################
echo $filename "is being moved to recovered folder."
date=`date +"%m%d%Y%H%M%S"`
cp $HOME/datafiles/$filename.txt $HOME/datafiles/recovered_file/$filename"_"$date.txt
cp $HOME/datafiles/$filename.xml $HOME/datafiles/recovered_file/$filename"_"$date.xml
echo $filename "files has been placed in recovered_file folder"
echo $filename "is being removed from datafiles folder."
rm -rf $HOME/datafiles/$filename*
echo $filename "is being removed from issue folder."
rm -rf $HOME/datafiles/issue_file/$filename*
TIME=`date +"%H:%M:%S"`
echo $filename "file is removed as $TIME"
echo "Processing Finished for $proc_name at $TIME on $DATE"

exit 0