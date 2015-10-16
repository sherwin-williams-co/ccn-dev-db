#!/bin/sh
#################################################################
# Script name   : RSA_WEBSERVICE_IPFILE_FTP.sh
#
# Description   : Use to ftp file to stexstdv.sw.sherwin.com server
#
# Created  : 08/13/2015 axk326 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="RSA_WEBSERVICE_IPFILE_FTP"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"` 
#File_Date=`date +"%d%h%Y" | tr [:lower:] [:upper:]`

echo "Processing Started for $proc_name at $TIME on $DATE"
# Move to datafiles folder from where ever you are in
cd /app/banking/dev/datafiles

export filename=DEPOSIT_TICKET_*.txt
var=`echo $filename`
cd /app/banking/dev/datafiles/issue_file
# get the file from the Server
ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd hpex/Apps/Bank_Deposit_Tickets/Input
get $var
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF
if [ ! -f $var ] ; then
    cd /app/banking/dev/datafiles
# ftp to ServerName 
ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd hpex/Apps/Bank_Deposit_Tickets/Input
mput $var 
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF
else
. /app/banking/dev/banking.config
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << END
set heading off;
set verify off;
execute MAIL_PKG.send_mail('DEPOSIT_TICKET_FILE',null,'$var'); 
exit;
END
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
    echo "processing FAILED for Sending Mail at ${TIME} on ${DATE}"
    exit 1;
fi
echo $var "file already exists. Check the file for processing first"
echo $var "file has been placed in recovered_file folder"
cp /app/banking/dev/datafiles/$var /app/banking/dev/datafiles/recovered_file/
rm -rf /app/banking/dev/datafiles/issue_file/DEPOSIT_TICKET_*.txt
echo $var "file is removed"
fi 

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################