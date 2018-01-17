#!/bin/sh
##########################################################
# Script to Run the reports
#
# modified: 08/23/2017 nxk927 CCN Project Team... 
# Added Script Comments and Handled exceptions 
##########################################################

. /app/banking/dev/banking.config

CLASSHOME=$HOME/bankingJavaCode

dt=`date`
DATE=`date +"%m-%d-%Y-%H%M%S"`
echo "START SRA30040 REPORT : $dt\n"

run=`cat $1`

for file in $run
do

echo "Running $file"

filename=`basename $file .rpt` 

cd "$CLASSHOME" || exit
java com.giftcardreport.GiftCardReport $HOME/giftcardreport/rpt/$file $HOME/giftcardreport/reports/$filename.pdf

#Check for Existance of generated report file before Starting the conversion process
if [ ! -f /app/banking/dev/giftcardreport/reports/$filename.pdf ]
    then
        echo "Exception occured while Converting /app/banking/dev/giftcardreport/reports/$filename.pdf to TXT file - PDF File not found.. Breaking out of Report Generation"
        exit 1
fi

echo "\n Converting to TXT"


#Archive PDF file
cp /app/banking/dev/giftcardreport/reports/$filename.pdf /app/banking/dev/giftcardreport/reports/current/archive/$filename"_"$DATE.pdf

#Check for Existance of converted report TXT file before Starting the currentization process
if [ ! -f /app/banking/dev/giftcardreport/reports/$filename.pdf ]
    then
        echo "Exception occured while converting/currentizing the TXT file /app/banking/dev/giftcardreport/reports/$filename.txt - File not found.. Breaking out of Report currentization"
        exit 1
fi

cp /app/banking/dev/giftcardreport/reports/$filename.pdf /app/banking/dev/datafiles/$filename.pdf
cp /app/banking/dev/giftcardreport/reports/$filename.pdf /app/banking/dev/giftcardreport/reports/current/archive/$filename"_"$DATE.pdf

done
dt1=`date`

echo "END SRA30040 REPORT  : $dt1\n"

exit 0
