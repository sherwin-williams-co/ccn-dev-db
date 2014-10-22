/*
--#################################################################
--# script name   : audit_load.sql
--#
--# description   : this script will 
--#                 execute a procedure defined in SQL Developer
--#
--# origin:  TAL 11/06/2012
--# change:
--#################################################################
*/

exec CCN_AUDIT_PKG.SELECT_HIERARCHY_AUDIT_LOG

exit;
END

echo "Returned from SQL PLUS"

TIME=`date +"%H:%M:%S"`
echo "\nProcessing finished for $1 at ${TIME}\n"  

exit 0

#############################################################
# END of PROGRAM.  
#############################################################


