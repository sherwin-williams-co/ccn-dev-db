#################################################################
# script name   : EXEC_PROC_1PARAM.sh
#
# description   : Wrapper for executing procedures with 1 parameter, accepts proc name and week number as paratmers 1 and 2
#
# CREATED : JXC517 12/11/2013
#    USED : AXK326 10/03/2014
#################################################################
# below command will get the path for fpr.config respective to the environment from which it is run from
. /app/ccn/host.sh

LOGDIR=$HOME/initLoad/STORDRFT
TimeStamp=`date '+%Y%m%d%H%M%S'`

proc_name=$1"(to_date('$2','MM/DD/YYYY'));"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw >> $LOGDIR/$1"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;

exec $proc_name

exit;
END

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME}"  

exit 0

##############################################################
# END of PROGRAM.  
#############################################################

