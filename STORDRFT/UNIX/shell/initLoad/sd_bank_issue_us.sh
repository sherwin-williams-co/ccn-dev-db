

###########################################################################################################
# script name   : STOREDRAFT																			  
#																										  
# description   : This script is to run the 
#					SD_BANKFILES_PKG.CREATE_US_AUTO_BANK_FILE
#					SD_BANKFILES_PKG.CREATE_US_NONAUTO_FILE
#					SD_BANKFILES_PKG.CREATE_CAN_NONAUTO_FILE
#					SD_BANKFILES_PKG.CREATE_CAN_AUTO_FILE
#   It performs the following steps - 																	  								
#   Gets user pwd for the DB connection from the stordrft.config										  
#   gets transaction date (##accepts transaction date as parameters)						  
#   calls DB procedures 
#					SD_BANKFILES_PKG.CREATE_US_AUTO_BANK_FILE
#					SD_BANKFILES_PKG.CREATE_US_NONAUTO_FILE
#					SD_BANKFILES_PKG.CREATE_CAN_NONAUTO_FILE
#					SD_BANKFILES_PKG.CREATE_CAN_AUTO_FILE
#				 to create bank files
#																									      
# created by : nxk927																					  	
# updated by : 																							  
###########################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from

. /app/ccn/host.sh

P1=`date --d "1 day ago" "+%m/%d/%Y"`


TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`


echo "START SD_BANKFILES_PKG Query : Processing Started at $TIME on $DATE "


sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw <<END
set heading off;
set serveroutput on;
--set feedback off;
--set pagesize 0;
set verify off;
--set echo off;

exec SD_BANKFILES_PKG.CREATE_US_AUTO_BANK_FILE(to_date('$P1','MM/DD/YYYY'));
exec SD_BANKFILES_PKG.CREATE_US_NONAUTO_FILE(to_date('$P1','MM/DD/YYYY'));



exit;
END

#write  "Status $stats"


#if test $stats -ne 0
#then
#		write  "FAILED $1"
#		exit 1;
#fi

					

TIME=`date +"%H:%M:%S"`
echo "END SD_BANKFILES_PKG Query : Processing finished at ${TIME}"  

exit 0

#############################################################
# END of PROGRAM.  
##############################################################


