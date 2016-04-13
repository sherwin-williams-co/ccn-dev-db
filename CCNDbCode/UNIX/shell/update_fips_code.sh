#############################################################################################################################
# Script name   : update_fips_code.sh
#
# Description   : This script is to run the FIPS_CODE_UPDATE_PKG.UPDATE_FIPS_CODE procedure that will update 
#                 the fips code in the address_usa table
# Created       : 04/13/2016 nxk927 CCN Project Team.....
# Modified      : 
#############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc_name="UPDATE_FIPS_CODE"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m%d%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $proc_name"_"$DATE.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
FIPS_CODE_UPDATE_PKG.UPDATE_FIPS_CODE();
EXCEPTION
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0