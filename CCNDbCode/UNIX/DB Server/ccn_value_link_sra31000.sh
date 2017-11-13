#!/bin/sh
###############################################################################################################################
# Script name   : ccn_generate_link_value.sh
#
# Description   : This script is to run the generate_value_link procedure
#
# Created  		: 11/06/2017 BXA919 CCN Project Team.....
# Modified 		: 11/13/2017 bxa919 Added exit condition
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_generate_link_value"
LOGDIR="$HOME/datafiles"
DATE=`date +"%m/%d/%Y"`

TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set serveroutput on;
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

execute CCN_BATCH_PROCESS.GENERATE_VALUE_LINK_PROCESS;

exit;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]
then
    echo " $proc_name --> processing FAILED while executing ccn_generate_link_value.sh at $DATE:$TIME "
    ./send_mail.sh "VALUELINK_FILE_FAILURE"
     exit 1
fi

$HOME/ccn_value_link_sra31000_ftp.sh 

exit 0

###############################################################################################################################
							END OF THE SCRIPT
###############################################################################################################################

