#!/bin/sh
#################################################################
# Script name   : SRA11000_Rename_file.sh
# Description   : This shell script will Rename the files.
#
# Created  : 03/03/2016 dxv848/nxk927 CCN Project Team.....
# Modified : 04/27/2016 nxk927 CCN Project Team.....
#            removed the error status check
#          : 08/23/2016 nxk927 CCN Project Team.....
#            changed the files that we consider for this process
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_Rename_file"
DATA_FILES_PATH="$HOME/initLoad"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#                                               Rename the files 
#################################################################
if ls $DATA_FILES_PATH/SRA10510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files exist to rename"
    cat $DATA_FILES_PATH/SRA10510_*.TXT >> $DATA_FILES_PATH/SRA10510.TXT
else
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files does not exist to rename"
fi

if ls $DATA_FILES_PATH/SRA10910_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA10910_*.TXT files exist to rename"
    cat $DATA_FILES_PATH/SRA10910_*.TXT >> $DATA_FILES_PATH/SRA10910.TXT
else
    echo "$DATA_FILES_PATH/SRA10910_*.TXT files does not exist to rename"
fi

if ls $DATA_FILES_PATH/UAR.MISCTRAN_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/UAR.MISCTRAN_*.TXT files exist to rename"
    cat $DATA_FILES_PATH/UAR.MISCTRAN_*.TXT >> $DATA_FILES_PATH/UAR.MISCTRAN.TXT
else
    echo "$DATA_FILES_PATH/UAR.MISCTRAN_*.TXT files does not exist to rename"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

