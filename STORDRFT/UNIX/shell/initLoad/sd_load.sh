##########################################################
# The Script is the master script for the SD Gain and loss data load for report and the JV
# It performs the following steps - 
#   calls DB procedures to load the store_draft_report table
#   calls DB procedures to load the gainloss_JV table
# 
#   Created  : 01/02/2015 NXK927
#   MOdified : 
##########################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc=sd_load
#############################################################
# BELOW PROCESS WILL 
# 1) 	TRUNCATE CCN_HIERARCHY_INFO TABLE AND PULL
# 		  DATA FROM HIERARCHY_DETAIL_VIEW TO UPDATE ANY CHANGES MADE
# 		  FOR FURTHER PROCESSING
# 2)    lOAD THE STORE_DRAFT_REPORT TABLE
#############################################################
TIME=`date +"%H:%M:%S"`
DATE=${SD_REPORT_QRY_RUNDATE}

echo "START sd_report_query.sh : Processing Started at $TIME on $DATE"
./sd_report_query.sh

TIME=`date +"%H:%M:%S"`
echo "END sd_report_query.sh : Processing finished at $TIME on $DATE"

#############################################################
# BELOW PROCESS WILL LOAD THE GAINLOSS_JV TABLE 	
#############################################################

TIME=`date +"%H:%M:%S"`
DATE=${GAINLOSS_MNTLY_RUNDATE}

echo "START gain_loss_JV.sh : Processing Started at $TIME on $DATE"
./gain_loss_JV.sh

TIME=`date +"%H:%M:%S"`
echo "END gain_loss_JV.sh : Processing finished at $TIME on $DATE"


############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
