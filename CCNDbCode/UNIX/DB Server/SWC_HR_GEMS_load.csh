
#################################################################
# script name   : CCN
#
# description   : Wrapper for executing procedure SWC_HR_GENERIC_VIEW
#
# created 	  : SXH487
# modified    : nxk927  09/25/2015       added the condition to exit out completely if there is any issues 
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
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
CCN_SWC_HR_GEMS_PKG.SWC_HR_GENERIC_VIEW_INFO_SP();
 Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
if [ 0 -ne "$?" ]; then
    echo "SWC_HR_GENERIC_VIEW_INFO_SP proc blew up." 
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('SWC_HR_GEMS_LOAD');
 Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
if [ 0 -ne "$?" ]; then
echo "SWC_HR_GENERIC_VIEW_INFO_SP - send_mail process blew up." 
else
echo "Sucessufully sent mail for the errors"
fi
exit 1
fi

TIME=`date +"%H:%M:%S"`
echo " END TRUCATING AND LOADING : Processing finished at ${TIME} "  

exit 0

#############################################################
# END of PROGRAM.  
#############################################################

