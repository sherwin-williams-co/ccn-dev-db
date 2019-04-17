##########################################################
# Script to Run the reports
#
# Created:  nxk927 12/13/2017 nxk927 - CCN Project Team... 
# modified: nxk927 02/21/2018 nxk927 - CCN Project Team... 
#           concatenating the reports to send mobius 1 report
# modified: nxk927 04/27/2018 nxk927 - CCN Project Team...
#           added unset display variable to let it run by user/bmc
#           as got display issue while running as user
# modified: 04/17/2019 sxg151 CCN Project Team...
#           Removed gs command which is creating specical characters after
#           Linux upgrade and moved the pdf concatination code to Java
##########################################################
. /app/ccn/ccn_app_server.config
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
dt=`date +"%m%d%Y"`
unset DISPLAY

echo "\nStarted Processing stores_div_roster_rpt at $TIME on $DATE "

./stores_div_roster_rpt.sh /app/ccn/crReports/data/stores_div_roster_rpt.txt  > /app/ccn/crReports/log/stores_div_roster_rpt${dt}.log 2>&1

#Verify status code and the log file for any instance of Exceptions or errors; If true then exit with status code 1
status=$?
if [ $status -ne 0 ]
then
    exit 1
fi

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