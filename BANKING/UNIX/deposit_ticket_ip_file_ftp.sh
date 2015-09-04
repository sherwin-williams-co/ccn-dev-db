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
# Move to initLoad folder from where ever you are in
cd /app/banking/dev/initLoad

if 
 ls BANK_DEPOSIT_INPUT_* &> /dev/null; then
    echo " Bank deposit ticket file exist "
	cat BANK_DEPOSIT_INPUT_* >> BANK_DEPOSIT_INPUT_FILE.txt
 else
    echo " Bank deposit ticket file doesn't exists "
fi

# ftp to ServerName 
ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd hpex/Apps/Bank_Deposit_Tickets/Input
put BANK_DEPOSIT_INPUT_FILE.txt bank_deposit_input_file.txt
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF

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