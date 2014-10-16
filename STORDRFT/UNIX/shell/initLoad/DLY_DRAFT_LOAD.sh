###############################################################################################################
# script name   : DLY_MAINT_MAINT																		  
#																										  
# description   : This script is to run the daily maintenance load for AutoMotive and Non AutoMotive 
#				  Also, to FTP the files to their corresponding mainframe server as well as archiving the same
#					DLY_DRAFT_US_AM.sh
#					DLY_DRAFT_US_NAM.sh
#					DLY_DRAFT_CAN_AM.sh
#					DLY_DRAFT_CAN_NAM.sh
#					DD_US_AM_FTP_ARCH.sh
#					DD_US_NAM_FTP_ARCH.sh
#					DD_CAN_AM_FTP_ARCH.sh
#					DD_CAN_NAM_FTP_ARCH.sh
#
#   It performs the following steps - 																	  								
#   Gets user pwd for the DB connection from the stordrft.config										  
#   gets transaction date (##accepts transaction date as parameters)						  
#   calls below shell scripts
#					DLY_DRAFT_US_AM.sh
#					DLY_DRAFT_US_NAM.sh
#					DLY_DRAFT_CAN_AM.sh
#					DLY_DRAFT_CAN_NAM.sh
#					DD_US_AM_FTP_ARCH.sh
#					DD_US_NAM_FTP_ARCH.sh
#					DD_CAN_AM_FTP_ARCH.sh
#					DD_CAN_NAM_FTP_ARCH.sh	 
#																									      
# created by : axk326 10/03/2014																					  	
# updated by : 																							  
###########################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from

. /app/ccn/host.sh

P1=`date --d "1 day ago" "+%m/%d/%Y"`


TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`


echo "STARTED PROCESSING THE SHELL SCRIPTS : Processing Started at $TIME on $DATE "

./DLY_DRAFT_US_AM.sh
./DLY_DRAFT_US_NAM.sh
./DLY_DRAFT_CAN_AM.sh
./DLY_DRAFT_CAN_NAM.sh
./DD_US_AM_FTP_ARCH.sh
./DD_US_NAM_FTP_ARCH.sh
./DD_CAN_AM_FTP_ARCH.sh
./DD_CAN_NAM_FTP_ARCH.sh	 

TIME=`date +"%H:%M:%S"`
echo "END PROCESSING THE SHELL SCRIPTS : Processing finished at $TIME on $DATE "  

#################################################
#    ERROR STATUS CHECK DLY_DRAFT_LOAD.sh 
#################################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for DLY_DRAFT_LOAD at ${TIME} on ${DATE}"
     exit 1;
fi

exit 0

#############################################################
# END of PROGRAM.  
##############################################################