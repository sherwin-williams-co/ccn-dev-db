#!/bin/sh
###############################################################################################################################
# Script name   : call_polling_future_load_process.sh
# Description   : This shell script calls the a remote shell script on DB server
#
#
# Created  : 01/19/2018 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

host_name=$CCNDBSERVERHOST
user_name=$CCNDBUSERNAME
password=$CCNDBPASSWORD
/usr/bin/expect >> $HOME/log/polling_futures_load_process.log << EOD
spawn /usr/bin/ssh -o Port=22 -o StrictHostKeyChecking=no $user_name@$host_name
expect "password:"
send "$password\r"
expect "$ "
send "cd $db_env_folder\r"
expect "$ "
send "pwd\r"
expect "$ "
send "sh $db_env_folder/polling_futures_load_process.sh\r"
expect "$ "
send -- "exit\r"
send -- "exit\r"
exit 0
EOD
exit 0
