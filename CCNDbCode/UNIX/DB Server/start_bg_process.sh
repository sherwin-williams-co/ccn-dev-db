#start background process to check for hierarchy loads
nohup sh /app/ccn/host_hierarchy.sh > /app/ccn/host_hierarchy.log 2>&1 &

#start background process to check for unix commands from PLSQL
nohup sh /app/ccn/host_unix_command.sh > /app/ccn/host_unix_command.log 2>&1 &

#start background process to check for audit
nohup sh /app/ccn/audit_files_check.sh > /app/ccn/audit_files_check.log 2>&1 &
