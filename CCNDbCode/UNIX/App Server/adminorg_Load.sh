#!/bin/sh

##########################################################################################
#
# purpose of this script will be to send files to Jeffery team on Adminorg_hierarchy_attributes
# details and perform the following steps:
# 1. establish connection to SQLPLUS
# 2. Get details from view with header details
#    and load to CSV  file
#
# Date Created: 07/05/2018 kxm302
# Date Updated: 
#
##########################################################################################


# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`

echo "Processing Started for ADMINORG_HIERARCHY_ATTRBT_VW report  at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<EOF
SET NEWPAGE 0
SET SPACE 0
SET LINESIZE 1000
SET PAGESIZE 0
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
set TERM OFF

EXECUTE CCN_BATCH_PROCESS.GEN_ADMINORG_HRCHY_ATTR_FILE();	
 
exit;
EOF

echo "Processing completed for file ADMINORG_HIERARCHY_ATTRBT_VW at $TIME on $DATE"
