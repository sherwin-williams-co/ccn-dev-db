#!/bin/sh
########################################################################################################################################################
# Script name : pos_data_check.sh
# Description : Script to validate data source is ready to run
#     Created : 07/20/2017 nxk927
#             : 07/25/2017 nxk927
#                added a check to see if it is saturday, run it regardles of stores_ach file being present or not
#             : 09/25/2017 nxk927
#               removed the condition to check for stores_ach file
########################################################################################################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#####################################################################
# Below datacheck will get either READY or NOTREADY from pos_data_check.sql
# if datacheck is READY then check for stores_ach.txt file or if its saturday
# if datacheck is NOTREADY then wait it till it gets the data
#####################################################################
proc="pos_data_check"
DATE=`date '+%Y-%m-%d'`
init_path="$HOME/initLoad"

while true;
do
    data=`sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << EOF
       @$HOME/pos_data_check.sql
exit;
EOF`
   if [ "$data" = READY ]
   then
      day=`date +%a`
      TIME=`date +"%H:%M:%S"`
      echo "Processing Started for $proc at $TIME on $DATE"
      ./SRA11000_dailyRun.sh
      TIME=`date +"%H:%M:%S"`
      echo "Processing finished for $proc at $TIME on $DATE"
      exit 0
   fi
done
exit 1