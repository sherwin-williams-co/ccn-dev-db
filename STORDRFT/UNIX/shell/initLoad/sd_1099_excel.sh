

###########################################################################################################
# script name   : STOREDRAFT																			  
#																										  
# description   : This script is to run the 
#					SD_FILE_BUILD_PKG.STORE_DRAFT_INTALLER_1099
##   It performs the following steps - 																	  								
#   Gets user pwd for the DB connection from the stordrft.config										  
#   gets transaction date (##accepts transaction date as parameters)						  
#   calls DB procedures 
#					SD_FILE_BUILD_PKG.STORE_DRAFT_INTALLER_1099
#					to create 1099 excel file
#																									      
# created by : nxk927																					  	
# updated by : 																							  
###########################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from

. /app/ccn/host.sh

P1=`cat $HOME/initLoad/STORDRFT/param.lst`

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`


echo "START STORE_DRAFT_INTALLER_1099 Query : Processing Started at $TIME on $DATE "


sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw <<END
set heading off;
set serveroutput on;
--set feedback off;
--set pagesize 0;
set verify off;
--set echo off;

exec SD_FILE_BUILD_PKG.STORE_DRAFT_INTALLER_1099(to_date('$P1','MM/DD/YYYY'));


exit;
END

#write  "Status $stats"


#if test $stats -ne 0
#then
#		write  "FAILED $1"
#		exit 1;
#fi

					

TIME=`date +"%H:%M:%S"`
echo "END STORE_DRAFT_INTALLER_1099 Query : Processing finished at ${TIME}"  

exit 0

#############################################################
# END of PROGRAM.  
##############################################################


