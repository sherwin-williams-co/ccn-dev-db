#!/bin/sh
#################################################################
# Script name   : POS_DOWNLOADS_CLEAN_UP.sh
# Description   : This shell script will call connect to sqlplus and run the 
#                 necessary program to clean up the pos_downloads table
#                   
# Created  : 09/07/2017 rxv940 CCN Project ....
# Modified : 
#              
#################################################################
. /app/ccn/host.sh

IN_FILE_TYPE=$1

echo " Connecting to the DB .... "

sqlplus -s -l $ccn_utility_un/$ccn_utility_pwd <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
:exitCode := 0;
DELETE FROM CCN_UTILITY.POS_DOWNLOADS
WHERE FILE_TYPE = '$IN_FILE_TYPE';

COMMIT;

Exception
when others then
    :exitCode := 1;
    rollback;
END;
/
exit :exitCode

EOF

status=$?
if [ $status -ne 0 ]
then
    echo " processing FAILED while deleting ..."
    exit 1
fi

echo " Processing Finished ..."
exit 0

############################################################################
