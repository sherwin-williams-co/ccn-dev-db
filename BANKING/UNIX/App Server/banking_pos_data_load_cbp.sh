#!/bin/sh
########################################################################################################################################################
# Script name : banking_pos_data_load_cbp.sh
# Description : Script to check if data is available on source (i.e. POS) so that Data load process can be run.
#     Created : gxg192 06/16/2017 CCN Project Team.....
#     Modified: gxg192 06/22/2017 Changes to call single shell script for loading data for gift card and ticket/bags
########################################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#####################################################################
# Below datacheck will get status as either READY or NOTREADY from pos_daily_data_check.sql
# if data status is READY then run the daily load
# if data status is NOTREADY then wait till data is ready for loading.
#####################################################################
proc="banking_pos_data_load_cbp"
TIME=`date +"%H:%M:%S"`
DATE=`date '+%Y-%m-%d'`

echo "Processing Started for $proc at $TIME on $DATE"
while true;
do
   data_status=`sqlplus -S -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << EOF
      @$HOME/sql/pos_daily_data_check.sql
exit;
EOF`
   if [ $data_status = READY ]
   then
      ./ccn_bnkng_daily_pos_load.sh
      status=$?
      if [ $status -ne 0 ];
      then
         TIME=`date +"%H:%M:%S"`
         echo "Processing FAILED for ccn_bnkng_daily_pos_load.sh at ${TIME} on ${DATE}"
      fi
      exit 0
   fi
done
exit 1