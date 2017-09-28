#!/bin/sh
###############################################################################################################################
# Script name   : init_loads_web_service.sh
# Description   : This script is to connect to DB and generate the .queue file, archive the two .queue files and calls
#               : the Init loads
#
# Created  : 09/27/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/host.sh

IN_FILE_NAME=$1
echo $IN_FILE_NAME
PROC_NAME=ter_mv_posfiles_to_app_server.sh
DATADIR="$HOME"/datafiles
ARCHIVEDIR="$DATADIR"/polling/archive
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Process started at $DATE:$TIME " 

# Run the SP to get the "COST_CENTER_DEQUEUE.queue" difference file

sqlplus -s -l $ccn_utility_un/$ccn_utility_pwd <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
:exitCode := 0;
P_GENERATE_STORE_LIST('$IN_FILE_NAME');
Exception
when others then
    :exitCode := 1;
END;
/
exit :exitCode

EOF

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]
then
    echo " $PROC_NAME --> processing FAILED while executing CCN_UTILITY.P_GENERATE_STORE_LIST at $DATE:$TIME "
    ./send_mail.sh "POLLING_FAILURE_MAIL" "Error while calling CCN_UTILITY.P_GENERATE_STORE_LIST"
     exit 1
fi
TIME=$(date +"%H%M%S")

cd "$DATADIR" || exit

# Archive the file from APP server 
mv "$DATADIR/CCD_LIST.queue" "$ARCHIVEDIR"


if [ -s "$CCD.queue" ]
then 

# FTP the difference file
$HOME/polling_dwnld_files_ftp_to_app_server.sh "$CCD.queue"

# Call the Init load based on the file type

if [ "$IN_FILE_NAME" = "STORE" ]
then

    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Calling Init load for Store started at $DATE:$TIME "
sqlplus -s -l $ccn_utility_un/$ccn_utility_pwd <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
:exitCode := 0;
POS_DATA_GENERATION.INIT_LOAD_STORE_SP;
Exception
when others then
    :exitCode := 1;
END;
/
exit :exitCode

EOF


    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Calling Init load for STORE ended at $DATE:$TIME "
	
elif [ "$IN_FILE_NAME" = "TERR" ]
then

    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Calling Init load for TERR started at $DATE:$TIME "
	
sqlplus -s -l $ccn_utility_un/$ccn_utility_pwd <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
:exitCode := 0;
POS_DATA_GENERATION.INIT_LOAD_TERR_SP;
Exception
when others then
    :exitCode := 1;
END;
/
exit :exitCode

EOF

    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Calling Init load for TERR ended at $DATE:$TIME "
	
elif [ "$IN_FILE_NAME" = "PARAM" ]
then

    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Calling Init load for PARAM started at $DATE:$TIME "
	
sqlplus -s -l $ccn_utility_un/$ccn_utility_pwd <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
:exitCode := 0;
POS_DATA_GENERATION.INIT_LOAD_PARAM_SP;
Exception
when others then
    :exitCode := 1;
END;
/
exit :exitCode

EOF

    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Calling Init load for PARAM ended at $DATE:$TIME "
fi
############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]
then
    echo " $PROC_NAME --> processing FAILED while calling Init load using POS_DATA_GENERATION at $DATE:$TIME "
    ./send_mail.sh "POLLING_FAILURE_MAIL" "Error while calling CCN_UTILITY.P_GENERATE_STORE_LIST"
     exit 1
fi
TIME=$(date +"%H%M%S")

##############################################
# Archive the difference file

mv -f "$DATADIR/$CCD.queue" "$ARCHIVEDIR"

echo " $PROC_NAME --> Processing Finished at $DATE:$TIME "

else

    echo " $CCD.queue file is not created "

fi