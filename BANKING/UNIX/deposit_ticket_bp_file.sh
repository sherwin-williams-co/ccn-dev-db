#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/deposit_ticket_bp_file.sh > $HOME/depsit_tckt_bgp_file.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep deposit_ticket_bp_file.sh

#path where the hierarchy files are stored
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

file_path="$HOME/datafiles"
archieve_path="$HOME/datafiles/archieve"

# Search for the file named DEPOSIT_TICKET_*.txt
while true; do
   if [ -s $file_path/DEPOSIT_TICKET_*.txt ]
   then
      sh deposit_ticket_ip_file_ftp.sh
	  date=`date +"%Y-%m-%d.%H%M%S"`
          
      echo "copying files from $file_path to $archieve_path"
      # Copy all the deposit ticket files from $HOME/hier to $HOME/archieve_path
      cp -pf $file_path/DEPOSIT_TICKET_*.txt $archieve_path

      echo "removing the files from $file_path"  
      # Rename the file to something else for future running purpose
      rm -rf $file_path/DEPOSIT_TICKET*.txt
	  
   fi
done

echo "ftp process completed for this run - but should not come to this point"