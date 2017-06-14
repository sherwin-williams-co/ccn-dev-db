#!/bin/sh
########################################################################################################################################################
# Script name : SRA30000_gift_card_process.sh
# Description : Script to validate data source is ready to run
#     Created : gxg192 06/08/2017
########################################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#####################################################################
# Below datacheck will get either READY or NOTREADY from gc_daily_data_check.sql
# if datacheck is READY then run the daily load 
# if datacheck is NOTREADY then wait till data is ready for loading.
#####################################################################
proc="SRA30000_gift_card_process"
TIME=`date +"%H:%M:%S"`
DATE=`date '+%Y-%m-%d'`

echo "Processing Started for $proc at $TIME on $DATE"
while true;
do
   data=`sqlplus -S -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << EOF
      @$HOME/sql/gc_daily_data_check.sql
exit;
EOF`
echo $data
   if [ $data = READY ]
   then
      DATE=`date +"%m/%d/%Y"`
      TIME=`date +"%H:%M:%S"`
      ./SRA30000_dailyRun.sh
      status=$?
      if [ $status -ne 0 ];
      then
         TIME=`date +"%H:%M:%S"`
         echo "Processing FAILED for SRA30000_dailyRun at ${TIME} on ${DATE}"
      fi
   else
      exit 1
   fi
echo "Processing completed for $proc at $TIME on $DATE"
exit 0
done
