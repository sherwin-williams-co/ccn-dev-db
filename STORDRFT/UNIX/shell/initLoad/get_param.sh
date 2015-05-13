#!/bin/sh
#############################################################################
# Script Name : get_param.sh
#
# Description : This shell script will create param.lst file by spooling from 
#	            storedrft_param table.                  
# 
# Created     : 01/14/2015 sxt410 Store Draft Project
# Modified    : 02/04/2015 sxt410 Added set linesize 10 to avoid extra white space.
#             : 04/27/2015 axk326 CCN Project Team.....
#               Substituted hard coded date value with the date value from date_param.config file
############################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo -e "\nBegin Get Parameter: Processing Started at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END

set pages 0
set feedback off
set linesize 10

spool $HOME/initLoad/param.lst

select to_char(PL_GAIN_RUNDATE,'mm/dd/yyyy')from storedrft_param;

spool off
exit;

END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for Get Parameter at $TIME on $DATE"
     exit 1;
fi

echo -e "End Get Parameter: Processing finished at ${TIME} on ${DATE}\n"
############################################################################
