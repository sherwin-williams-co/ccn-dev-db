#!/bin/sh
#############################################################################
# Script Name : get_param.sh
#
# Description : This shell script will create param.lst file by spooling from 
#	            storedrft_param table.                  
# 
# Created     : 01/14/2015 sxt410 Store Draft Project
# Modified    : 02/04/2015 sxt410 Added set linesize 10 to avoid extra white space.
#             : 03/18/2016 nxk927 CCN Project Team.....
#               Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#               the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#             : 03/24/2016 nxk927 CCN Project Team.....
#               changed the error check to make it uniform
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

select to_char(closing_date,'mm/dd/yyyy')from storedrft_param;

spool off
exit;

END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for Get Parameter at $TIME on $DATE"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo -e "End Get Parameter: Processing finished at ${TIME} on ${DATE}\n"
############################################################################
