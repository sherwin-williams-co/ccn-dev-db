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

echo -e "\nBegin Get Parameter"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END

set pages 0
set feedback off

spool $HOME/initLoad/param.lst

select to_char(closing_date,'mm/dd/yyyy')from storedrft_param;

spool off
exit;

END
echo -e "End Get Parameter\n"