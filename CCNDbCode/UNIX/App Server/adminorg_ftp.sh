#!/bin/sh

##########################################################################################
#
# purpose of this script is to ftp the file ADMINORG_HRCHY_ATTRBT csv file 
# details and perform the following steps:
# 1. establish connection to server 
# 2. put the csv file from CCN SB server to destination server
#
# Date Created: 07/05/2018 kxm302
# Date Updated: 
#
##########################################################################################


# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 cdate=`date +'%m%d%y'`

echo "Processing Started for ftp the ADMINORG_HRCHY_ATTRBT csv file at $TIME on $DATE"

src_file_name="/app/ccn/dev/datafiles/ADMINORG_HRCHY_ATTRBT_$cdate.csv"
dest_file_name="AdminOrgHierarchyAttrbt_$cdate.csv"

ftpResult=`ftp -n $CCNAPPSERVER_HOST <<FTP_MF
quote USER $CCNAPPSERVER_USERNAME
quote PASS $CCNAPPSERVER_PASSWORD
put $src_file_name /app/banking/dev/datafiles/$dest_file_name
bye
FTP_MF`
echo "FTP to stap3ccndwv COMPLETED"
