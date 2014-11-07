#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/dailyLoad/daily_paids_filewatcher.sh > $HOME/dailyLoad/archieve/logs/daily_paids_filewatcher.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -elf | grep -i daily_paids_filewatcher.sh

#path where the hierarchy files are stored
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

daily_paids_path="$HOME/dailyLoad"
datafiles_path="$HOME/initLoad"
originalfile="$datafiles_path/STBD0601_PAID_*.TXT"

# Search for the file named STBD0601_PAID_*.TXT STBD0101_PAID_*.TXT
while true; 
do
   if [ -s $datafiles_path/STBD0601_PAID_*.TXT ]
   then
      echo "running the ccn_sd_daily_paids_load.sh script to load the daily paids"
      sh $daily_paids_path/ccn_sd_daily_paids_load.sh
   fi
   if [ -s $datafiles_path/STBD0101_PAID_*.TXT ]
   then
      echo "running the ccn_sd_daily_paids_load.sh script to load the daily paids"
      sh $daily_paids_path/ccn_sd_daily_paids_load.sh
   fi
done

echo "process completed - but should not come to this point"
