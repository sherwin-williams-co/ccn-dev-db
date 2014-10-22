/*
--#################################################################
--# 111script name   : audit_call_DB
--#
--# description   : this script will make the call to the database
--#                 and execute a procedure defined in SQL Developer
--#
--# origin:  TAL 11/06/2012
--# change:
--#################################################################
*/

exec CCN_AUDIT_PKG.SELECT_AUDIT_LOG

exit;
END

echo "Returned from SQL PLUS"

#write  "Status $stats"


#if test $stats -ne 0
#then
#		write  "FAILED $1"
#		exit 1;
#fi

TIME=`date +"%H:%M:%S"`
echo "\nProcessing finished for $1 at ${TIME}\n"  

exit 0

#############################################################
# END of PROGRAM.  
#############################################################


