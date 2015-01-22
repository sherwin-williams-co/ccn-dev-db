#!/bin/sh
#############################################################################
# Script Name : get_param.sh
#
# Description : This shell script will create param.lst file by spooling from 
#	            storedrft_param table.                  
# 
# Created     : 01/14/2015 sxt410 Store Draft Project
# Modified    :  
############################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo -e "\nBegin Get Parameter: Processing Started at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END

set pages 0
set feedback off

spool $HOME/initLoad/param.lst

select to_char(closing_date,'mm/dd/yyyy')from storedrft_param;

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
