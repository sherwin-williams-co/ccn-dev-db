#!/bin/sh
##########################################################
# Script to Cleanup the generated files after completion of process or during errors
# Created:  5/16/2017 rxa457 CCN Project team..
##########################################################

###############################################
# Remove the generated report TXT and PDF files
###############################################
echo "\nSTART CLEANUP: Cleaning up Generated TXT and PDF files(If Any) to avoid sending previous month files"

FPATH="/app/strdrft/sdReport/reports/final"
FPATH2="/app/strdrft/sdReport/reports"
run=`cat /app/strdrft/sdReport/data/run1.txt`

for file in $run
do
	filename=`basename $file .rpt` 
	if [ -f $FPATH/$filename.txt ]
	then
		echo "Removing $FPATH/$filename.txt"
		rm -f $FPATH/$filename.txt
	fi
	if [ -f $FPATH2/$filename.pdf ]
	then
		echo "Removing $FPATH2/$filename.pdf"
		rm -f $FPATH2/$filename.pdf
	fi
done 

if [ -f $FPATH/glreport.txt ]
then
	echo "Removing $FPATH/glreport.txt"
	rm -f $FPATH/glreport.txt
fi

LOGDIR=/app/strdrft/sdReport/logs
THISSCRIPT="Monthly_Reports_Run_bp"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log	

echo "END CLEANUP\n"

echo "Monthly_Reports_Run_bp.log has been archived as $LOG_NAME\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"

#Archive Log file
cp $LOGDIR/$THISSCRIPT.log $LOGDIR/$LOG_NAME

exit 0
############################################################################
# End of Program
############################################################################
