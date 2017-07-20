#!/bin/sh
########################################################################################################################################################
# Script name : pos_data_check.sh
# Description : Script to validate data source is ready to run
#     Created : 07/20/2017 nxk927
########################################################################################################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#####################################################################
# Below datacheck will get either READY or NOTREADY from sd_daily_data_check.sql
# if datacheck is READY then create LOAD_READY.TRG file
# if datacheck is NOTREADY send mail once and check for the file.
#####################################################################
proc="pos_data_check"
LOGDIR=$HOME/logs
TIME=`date +"%H:%M:%S"`
DATE=`date '+%Y-%m-%d'`
TimeStamp=`date '+%Y%m%d%H%M%S'`
init_path="$HOME/initLoad"

echo "Processing Started for $proc at $TIME on $DATE"
while true;
do
    data=`sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << EOF
       @$HOME/pos_data_check.sql
exit;
EOF`
   if [ $data = READY ] && [ -f $init_path/stores_ach.txt ]
   then
      DATE=`date +"%m/%d/%Y"`
      TIME=`date +"%H:%M:%S"`
      echo "Processing Started for $proc at $TIME on $DATE"
      ./SRA11000_dailyRun.sh
      exit 0
   fi
done
exit 0