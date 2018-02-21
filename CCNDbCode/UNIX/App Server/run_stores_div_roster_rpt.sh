##########################################################
# Script to Run the reports
#
# Created:  nxk927 12/13/2017 nxk927 - CCN Project Team... 
# modified: nxk927 02/21/2018 nxk927 - CCN Project Team... 
#           concatenating the reports to send mobius 1 report
##########################################################
. /app/ccn/ccn_app_server.config
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
dt=`date +"%m%d%Y"`

echo "\nStarted Processing stores_div_roster_rpt at $TIME on $DATE "

./stores_div_roster_rpt.sh /app/ccn/crReports/data/stores_div_roster_rpt.txt  > /app/ccn/crReports/log/stores_div_roster_rpt${dt}.log 2>&1

#Verify status code and the log file for any instance of Exceptions or errors; If true then exit with status code 1
status=$?
if [ $status -ne 0 ]
then
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "\nStarted concatenating the reports to one output at $TIME on $DATE "

cd /app/ccn/crReports/reports
gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=CCN05000.pdf  RPT40_ALPHA_SEQ_STORES.pdf RPT41_NUMERIC_SEQ_STORES.pdf RTP42_COST_CTRS_DAD_SEQ.pdf RPT43_COST_CTRS_NMERIC_SEQ.pdf RPT44_CLOSED_COST_CTRS.pdf RPT46_CHANGES_ALPHA_SEQ.pdf RPT47_CHANGES_NUMERIC_SEQ.pdf

TIME=`date +"%H:%M:%S"`
echo "\nCopmpleted Concatenating the reports to one output at $TIME on $DATE "

TIME=`date +"%H:%M:%S"`
echo "\nStarted running clean temp files at $TIME on $DATE "

# Call the Script to Clean Crystal Report temp files
cd /app/ccn/scripts
./remove_crtmp.sh

echo "\n ended running clean temp files at $TIME on $DATE "

echo "\nCompleted Processing stores_div_roster_rpt at $TIME on $DATE "

exit 0
############################################################################
# End of Program
############################################################################