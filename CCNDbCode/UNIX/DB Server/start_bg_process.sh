
#start background process to check for unix commands from PLSQL
nohup sh /app/ccn/host_unix_command.sh > /app/ccn/host_unix_command.log 2>&1 &

