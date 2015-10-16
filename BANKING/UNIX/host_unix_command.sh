#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/host_unix_command.sh > $HOME/logs/host_unix_command.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep host_unix_command.sh

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

# Search for the file named audit_start
while true; do
   if [ -s $HOME/audit_start ]
   then
      echo "running the passed in command"
      sh $HOME/batchJobs/backFeed/Main_Audit.sh

      rm $HOME/audit_start 
   fi
done

echo "process completed - but should not come to this point"
