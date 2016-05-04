#!/bin/sh
#################################################################
# Script name   : RSA_WEBSERVICE_IPFILE_FTP.sh
#
# Description   : Use to ftp file to stexstdv.sw.sherwin.com server
#
# Created  : 08/13/2015 axk326 CCN Project Team.....
# Modified : 02/05/2016 nxk927 CCN Project Team.....
#             changed the scripts to check if there are any un processed deposit ticket for the cost center
#             for which new deposit ticket is created.
#             added the time stamp in the file to be placed in the archieve and the recover folder
#          : 04/05/2016 nxk927 CCN Project Team.....
#             modularized the code
#             This script does the following
#             1) checks if the .txt file is present on their server (stexstdv.sw.sherwin.com) that means it is unprocessed
#             2) checks if the .xml file is present on their server (stexstdv.sw.sherwin.com) that means it is unprocessed
#             3) if any one is not processed(present) then send email and archive the files to recovered folder
#             4) if none are present, then ftp it and archive in archive folder
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="RSA_WEBSERVICE_IPFILE_FTP"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"` 

echo "Process started for $proc_name at $TIME on $DATE"
cd $HOME/datafiles

file_name=DEPOSIT_TICKET_*.txt
fname=$(echo $file_name | cut -f 1 -d '.')
TIME=`date +"%H:%M:%S"`
############################################################################
echo "Process started for get_deposit_tkt_txt at $TIME on $DATE"
#this will check if the deposit ticket (txt) for same cost center is processed or not.
#by getting the file from their server. If the file is present, then it means the files is not yet processed

cd $HOME
./get_deposit_tkt_txt.sh $fname
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
TIME=`date +"%H:%M:%S"`
echo "Process finished for get_deposit_tkt_txt at $TIME on $DATE"

############################################################################
TIME=`date +"%H:%M:%S"`
echo "Process started for get_deposit_tkt_xml at $TIME on $DATE"
#this will check if the deposit ticket (xml) for same cost center is processed or not.
#by getting the file from their server. If the file is present, then it means the files is not yet processed

./get_deposit_tkt_xml.sh $fname
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
TIME=`date +"%H:%M:%S"`
echo "Process finished for get_deposit_tkt_xml at $TIME on $DATE"

############################################################################
TIME=`date +"%H:%M:%S"`
echo "Process started for deposit_tkts_file_chk at $TIME on $DATE"
#this will check if the files are present in our issue file folder (meaning the file is not processed in their server)
#if the file is present then we will send email to get the file processed before we ftp the new file
#else we will ftp the files to be processed
./deposit_tkts_file_chk.sh $fname
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
TIME=`date +"%H:%M:%S"`
echo "Process finished for deposit_tkts_file_chk at $TIME on $DATE"
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################