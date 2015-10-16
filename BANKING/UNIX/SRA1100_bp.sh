#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/SRA1100_bp.sh > $HOME/SRA1100_bp.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep SRA1100_bp.sh

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#path where the Command file is stored
cmd_path="$HOME/initLoad"
# Search for the file named cmd_start.sh
while true; do
   if [ -f $cmd_path/SRA10510_*.TXT ] &&  [ -f $cmd_path/SRA13510_*.TXT ]  &&  [ -f $cmd_path/SRA11060_*.TXT ]
   then
	  sh $HOME/SRA11000_dailyRun.sh
   fi
done

echo "process completed - but should not come to this point"


