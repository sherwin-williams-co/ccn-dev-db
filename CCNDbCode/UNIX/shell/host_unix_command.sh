#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/host_unix_command.sh > $HOME/host_unix_command.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -elf | grep -i host_unix_command.sh

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

#path where the Command file is stored
cmd_path="$HOME/datafiles"

# Search for the file named cmd_start.sh
while true; do
   if [ -s $cmd_path/cmd_start.sh ]
   then
      sh $HOME/bnkng_audit_strt_ftp.sh
	  
      now=`date +"%Y-%m-%d.%H%M%S"`
      renamedfile="$cmd_path/cmd_start.$now.sh"
      # Example renamedfile: $HOME/datafiles/cmd_start.2013-10-30.134513.sh
      echo "running the passed in command"
      sh $cmd_path/cmd_start.sh

      echo "renaming the files from $cmd_path/cmd_start.sh to $renamedfile"
      mv -f $cmd_path/cmd_start.sh $renamedfile
   #else
      #echo "searching for $cmd_path/cmd_start.sh"
   fi
done

echo "process completed - but should not come to this point"
