
###########################################################################################
# Script Name    :  ftp_mq_convert_file.sh
#
# Description    :  This shell program will ftp the POS file to mainframe
#                   
# Created        :  AXK326/DXV848 09/04/2015
###########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from

. /app/ccn/host.sh

proc="FTP_MQ_CONVERT_FILE"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
file_date=`date +"%d%b%Y"`
CURR_PATH="$HOME/initLoad"

echo "Processing Started for $proc at $TIME on $DATE"

cd $CURR_PATH
if 
    ls POS_FILE_$file_date &> /dev/null; then
    echo " POS file exist "
    mv POS_FILE_$file_date MQ_CONVERT_FILE
else
    echo " POS file doesn't exist "
fi

echo "Execute FTP to Mainframe" 
ftp -n $mainframe_host <<FTP_MF
quote USER $mainframe_user
quote PASS $mainframe_pw
quote SITE RECFM=FB,LRECL=2500,BLKSIZE=27500,SPACE=(300,150),VOL(GDG350) CYL
put MQ_CONVERT_FILE 'SMIS1.ORACLE.MQ.CONVERT(+1)' 
bye
FTP_MF
echo "FTP to Mainframe COMPLETED"

TIME=`date +"%H:%M:%S"`
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
#                     END  of  PROGRAM  
############################################################################