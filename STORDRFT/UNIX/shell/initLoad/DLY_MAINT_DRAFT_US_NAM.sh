###########################################################################################################
# script name   : DLY_MAINT_DRAFT_US_NAM																			  
#																										  
# description   : This script is to run the 
#					SD_AUDITFILES_PKG.CREATE_NAM_AUDIT_BANK_FILE
#
#   It performs the following steps - 																	  								
#   Gets user pwd for the DB connection from the stordrft.config										  
#   gets transaction date (##accepts transaction date as parameters)						  
#   calls DB procedure to create bank files
#
#					SD_AUDITFILES_PKG.CREATE_NAM_AUDIT_BANK_FILE				 
#																									      
# created by : axk326 10/02/2014																					  	
# updated by : 																							  
###########################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from

. /app/ccn/host.sh

P1=`date --d "1 day ago" "+%m/%d/%Y"`

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "START SD_AUDITFILES_PKG.CREATE_NAS_AUDIT_BANK_FILE Query : Processing Started at $TIME on $DATE "

./EXEC_PROC_1PARAM.sh "SD_AUDITFILES_PKG.CREATE_NAM_AUDIT_BANK_FILE" "$P1"

#################################################
#    ERROR STATUS CHECK DLY_MAINT_DRAFT_US_NAM.sh 
#################################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for DLY_MAINT_DRAFT_US_NAM at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "END SD_AUDITFILES_PKG.CREATE_NAM_AUDIT_BANK_FILE Query : Processing finished at $TIME on $DATE "  

exit 0

#############################################################
# END of PROGRAM.  
##############################################################