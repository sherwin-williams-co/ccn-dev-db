#!/bin/sh
##############################################################################################################
# Script name   : 1099_rerun_process.sh
# Description   : This shell script will re run 1099 Monthly and Mid Monthly from Jan 2015 to Apr 2015.
##############################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_rerun"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%I:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%m%d%Y%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;

BEGIN

	--This is monthly run that was ran on 01-Feb-2015
	dbms_output.put_line ( 'Start rerun Monthly process for 01-Feb-2015'); 
	    SD_FILE_BUILD_PKG.BUILD_1099_FILE('01-JAN-2015','N');
	dbms_output.put_line ( 'End of rerun Monthly process for 01-Feb-2015' || CHR(10));
	
	--This is mid-monthly run that was ran on 15-Feb-2015
	dbms_output.put_line ( 'Start rerun Mid-Monthly process for 15-Feb-2015'); 
		SD_FILE_BUILD_PKG.BUILD_1099_FILE('01-JAN-2015','Y');
	dbms_output.put_line ( 'End of rerun Mid-Monthly process for 15-Feb-2015' || CHR(10));
	
	
	--This is monthly run that was ran on 01-Mar-2015
	dbms_output.put_line ( 'Start rerun Monthly process for 01-Mar-2015'); 
		SD_FILE_BUILD_PKG.BUILD_1099_FILE('01-FEB-2015','N');
	dbms_output.put_line ( 'End of rerun Monthly process for 01-Mar-2015' || CHR(10));
	
	--This is mid-monthly run that was ran on 15-Mar-2015
	dbms_output.put_line ( 'Start rerun Mid-Monthly process for 15-Mar-2015'); 
		SD_FILE_BUILD_PKG.BUILD_1099_FILE('01-FEB-2015','Y');
	dbms_output.put_line ( 'End of rerun Mid-Monthly process for 15-Mar-2015' || CHR(10));
	
	
	--This is monthly run that was ran on 01-Apr-2015
	dbms_output.put_line ( 'Start rerun Monthly process for 01-Apr-2015'); 
		SD_FILE_BUILD_PKG.BUILD_1099_FILE('01-MAR-2015','N');
	dbms_output.put_line ( 'End of rerun Monthly process for 01-Apr-2015' || CHR(10));
		
	--This is mid-monthly run that was ran on 15-Apr-2015
	dbms_output.put_line ( 'Start rerun Mid-Monthly process for 15-Apr-2015'); 
		SD_FILE_BUILD_PKG.BUILD_1099_FILE('01-MAR-2015','Y');
	dbms_output.put_line ( 'End of rerun Mid-Monthly process for 15-Apr-2015' || CHR(10));
	
	
	--This is monthly run that was ran on 01-May-2015
	dbms_output.put_line ( 'Start rerun Monthly process for 01-May-2015'); 
		SD_FILE_BUILD_PKG.BUILD_1099_FILE('01-APR-2015','N');
	dbms_output.put_line ( 'End of rerun Monthly process for 01-May-2015' || CHR(10));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Process failed, please check');
END;
/
 
exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%I:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################