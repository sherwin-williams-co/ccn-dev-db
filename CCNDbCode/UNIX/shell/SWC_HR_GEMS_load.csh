
#################################################################
# script name   : CCN
#
# description   : Wrapper for executing procedure SWC_HR_GENERIC_VIEW
#
# created 	  : SXH487
#################################################################

##accepts date parameter
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo " START TRUCATING AND LOADING : Process Started at $TIME on $DATE "

sqlplus -s  $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
set serveroutput on;

EXECUTE CCN_SWC_HR_GEMS_PKG.SWC_HR_GENERIC_VIEW_INFO_SP();

exit

END

TIME=`date +"%H:%M:%S"`
echo " END TRUCATING AND LOADING : Processing finished at ${TIME} "  

exit 0

#############################################################
# END of PROGRAM.  
#############################################################

