#!/bin/sh
########################################################################################################################################################
# Script name : sd_data_status_check.sh
# Description : Script to validate data source is ready to run
#     Created : nxk927 06/02/2017
########################################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

#####################################################################
# Below datacheck will get either READY or NOTREADY from sd_daily_data_check.sql
# if datacheck is READY then create LOAD_READY.TRG file
# if datacheck is NOTREADY send mail once and check for the file.
#####################################################################
proc="Pos_daily_load"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=`date '+%Y-%m-%d'`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"
while true;
do
    data=`sqlplus -S $sqlplus_user/$sqlplus_pw << EOF
       @$HOME/dailyLoad/sd_daily_data_check.sql
exit;
EOF`
   if [ $data = READY ]
   then
      DATE=`date +"%m/%d/%Y"`
      TIME=`date +"%H:%M:%S"`
      echo "Processing Started for $proc at $TIME on $DATE"
     ./daily_drafts_load.sh
   fi
exit 0
done 