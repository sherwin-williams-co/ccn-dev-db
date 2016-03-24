##########################################################
# The Script is the master script for the SD Gain and loss data load for report and the JV
# It performs the following steps - 
#   calls DB procedures to load the store_draft_report table
#   calls DB procedures to load the gainloss_JV table
# 
#   Created  : 01/02/2015 NXK927
#   MOdified : 03/18/2016 nxk927 CCN Project Team.....
#              Added Error handling calls to exit out if there are any errors
#              Removed declared DATE variable from all the other place leaving only at the beginning
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
DATE=`date +"%m/%d/%Y"`

echo "START sd_report_query.sh : Processing Started at $TIME on $DATE"
./sd_report_query.sh

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for $proc at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "END sd_report_query.sh : Processing finished at $TIME on $DATE"

#############################################################
# BELOW PROCESS WILL LOAD THE GAINLOSS_JV TABLE 	
#############################################################

TIME=`date +"%H:%M:%S"`
echo "START gain_loss_JV.sh : Processing Started at $TIME on $DATE"
./gain_loss_JV.sh

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "END gain_loss_JV.sh : Processing finished at $TIME on $DATE"
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
