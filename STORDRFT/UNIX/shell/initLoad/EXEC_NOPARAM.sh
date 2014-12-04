#################################################################
# script name   : EXEC_NOPARAM
#
# description   : AXK326 CCN PROJECT TEAM....
#                 Wrapper for calling SQL load scripts, accepts file name <>.sql
#
#################################################################
# below command will get the path for fpr.config respective to the environment from which it is run from
. /app/stordrft/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

FILE_NAME=$1

echo " Processing Started at $TIME on $DATE for $FILE_NAME"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;

@$HOME/dailyLoad/$FILE_NAME;

exit;
END
	
TIME=`date +"%H:%M:%S"`
echo " Processing finished at ${TIME} for $FILE_NAME"  

exit 0

#############################################################
# END of PROGRAM.  
#############################################################

