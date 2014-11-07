##########################################################
# Script to Run the reports
#
# Created:  
##########################################################

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\nStarted running files at $TIME on $DATE "

./pl_gain.sh /app/strdrft/sdReport/data/run1.txt

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "\nCompleted running files at $TIME on $DATE "

############################################################################
# End of Program
############################################################################
