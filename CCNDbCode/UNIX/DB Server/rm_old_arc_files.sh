############################################################################################################################
# description: Shell Script to delete files in /app/ccn/dev/batchJobs/backFeed/Archive/ folder which are older than 6 months
# created    : 03/04/2015 SXT410  
############################################################################################################################

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

echo " Executing Script to remove files "

find $HOME/batchJobs/backFeed/Archive/ -maxdepth 1 -type f -mtime +182 -exec rm -f {} \;

echo " Files older than Six months are removed "

exit 0