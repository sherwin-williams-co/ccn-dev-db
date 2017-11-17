#!/bin/sh
#################################################################
# Script name   : Royal_Bank_Rename_file.sh
# Description   : This shell script will Rename the Royal Bank file
#                 and archive the original file
# Created       : 11/16/2017 sxh487 CCN Project Team.....
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Royal_Bank_Rename_file"
DATA_FILES_PATH="$HOME/datafiles"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
# Rename the input files
#################################################################
echo "Renaming input files started at ${TIME} on ${DATE}"
if ls $DATA_FILES_PATH/DAREPORT.* &> /dev/null; then
    echo "$DATA_FILES_PATH/DAREPORT.* files exist to rename"
    cat $DATA_FILES_PATH/DAREPORT.* >> $DATA_FILES_PATH/DAREPORT.txt
else
    echo "$DATA_FILES_PATH/DAREPORT.* files does not exist to rename"
fi
echo "Renaming input files finished at ${TIME} on ${DATE}"