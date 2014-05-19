#!/bin/sh

##########################################################################################
#
# Load_FIPS_Code_Updates.sh
#
# purpose of this script will be to control initiating the FIPS LOAD UPDATE for USA Addresses.
# this script will be called by a job scheduler and perform the following steps:
# 1. establish connection to SQLPLUS
# 2. call the script that will execute an SQL Database Procedure
#    this will Read the FIPS Update Records to:
#  a.  Update the associated ADDRESS_USA Table Entries.
#  b.  Write Errors and Report Tatals to the Error_log Table.
#
##########################################################################################


PROC="Load_FIPS_Code_Updates"

echo "Begin $PROC.sh script"

# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config

# establish parameter names for this script
USER=$sqlplus_user
PASS=$sqlplus_pw

# display parameter values
# echo "USER   =" $USER
# echo "PASS   =" $PASS
# echo "PROC   =" $PROC

# set date and time for message
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`
# echo "DATE = $DATE"
# echo "TIME = $TIME"
echo "Processing Started for $PROC.sql at $TIME on $DATE"

sqlplus -s -l $USER/$PASS <<END
set heading off;
set serveroutput on;
set verify off;

@$HOME/batchJobs/sql/Load_FIPS_Code_Updates.sql
 
exit;
END

# set date and time for message
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`
# echo "DATE = $DATE"
# echo "TIME = $TIME"
echo "Processing Return from $PROC.sql at $TIME on $DATE"
echo "Ended $PROC.sh script"

##############################
#  end of script             #
##############################
