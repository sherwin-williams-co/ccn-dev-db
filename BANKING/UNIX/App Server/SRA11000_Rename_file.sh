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
#          : 04/20/2017 nxk927 CCN Project Team.....
#            source file changed. Using the source file provided by marcy Lee.
#          : 07/20/2017 nxk927 CCN Project Team.....
#            source file changed. Using the source file provided by treasury.
#           : 09/21/2017 rxa457 CCN Project Team...
#             Removed renaming and archive process for Mainframe input files
#           : 09/25/2017 rxa457 CCN Project Team...
#             We will be recieving the stores_ach file in the ccn_users folder
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_Rename_file"
DATA_FILES_PATH="$HOME/initLoad"
MSCTRAN_PATH="$HOME/datafiles/ccn_users"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#                                               Rename the files 
#################################################################

if ls $MSCTRAN_PATH/stores_ach.txt &> /dev/null; then
    echo "$MSCTRAN_PATH/stores_ach.txt files exist to rename"
    mv $MSCTRAN_PATH/stores_ach.txt >> $DATA_FILES_PATH/stores_ach.txt
else
    echo "$MSCTRAN_PATH/stores_ach.txt files does not exist to rename"
fi


if ls $MSCTRAN_PATH/misctran*.txt &> /dev/null; then
    echo "$MSCTRAN_PATH/misctran.*.txt files exist to rename"
    cat $MSCTRAN_PATH/misctran*.txt >> $DATA_FILES_PATH/UAR.MISCTRAN.TXT
else
    echo "$MSCTRAN_PATH/misctran*.txt files does not exist to rename"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
