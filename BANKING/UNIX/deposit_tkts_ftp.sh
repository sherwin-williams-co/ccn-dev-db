#!/bin/sh
#################################################################
# Script name   : deposit_tkts_ftp.sh
#
# Description   : this scripts to check if there are any unprocessed deposit ticket for the cost center 
#                 in the server we are going to ftp the newly created deposit ticket
#
# Created  : 04/04/2016 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_tkts_ftp"
file_path="$HOME/datafiles"
archieve_path="$HOME/datafiles/archieve"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"` 
filename=$1
file1=$filename.txt
file2=$filename.xml
echo "Processing Started for $proc_name at $TIME on $DATE"

cd $HOME/datafiles/issue_file
# get the file from the Server to check if the file is present that needs to be processed first before 
# ftp'ing the newly created deposit ticket
if [ -f $file1 ] || [ -f $file2 ]; then
    cd $HOME
    ./deposit_tkt_send_mail.sh $filename
	 TIME=`date +"%H:%M:%S"`
     echo "Processing finished for $proc_name at ${TIME} on ${DATE}"	
else
    # ftp the files to the Server
	cd $HOME
	./deposit_tkt_txt_ftp.sh $file1
	./deposit_tkt_xml_ftp.sh $file2
     ############################################################################
     #                           ERROR STATUS CHECK 
     ############################################################################
     status=$?
     if test $status -ne 0
     then
        TIME=`date +"%H:%M:%S"`
        echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
        exit 1;
     fi
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
############################################################################