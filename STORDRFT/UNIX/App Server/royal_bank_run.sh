#!/bin/sh
#######################################################################
# Script Name : royal_bank_run.sh
# Description : This Shell Script Runs the crystal report
#               for royal banking and converts pdf file to
#               text file.
# Created     : 11/16/2017 sxh487
########################################################################
. /app/strdrft/dataloadInfo.txt

dt=`date`
DATE=`date +"%m-%d-%Y-%H%M%S"`
echo "START Royal Bank Report : $dt\n"
user=$sqlplus_user
passw=$sqlplus_pw
rep1=`cat $1`
 
fl1="1"

P1=`cat /app/strdrft/sdReport/data/param.lst|cut -d"|" -f1`
P2=`cat /app/strdrft/sdReport/data/param.lst|cut -d"|" -f2`

for file in $rep1
do

echo "Running $file"

filename=`basename $file .rpt` 
PATH=/usr/jdk/jdk1.7.0_17/bin:$PATH

#############################################################################################
#  Below command executes Royal_Bank_Debits.rpt file and a Royal_Bank_Detail.rpt.
#  Main report displays summary and details data for all the transit types
#############################################################################################

java -classpath .:../src:../lib/cvom.jar:../lib/log4j-1.2.14.jar:../lib/CrystalReportsRuntime.jar:../lib/ojdbc5-11.1.0.7.0.jar:../lib/CrystalCommon2.jar:../lib/DatabaseConnectors.jar:../lib/JDBInterface.jar:../lib/keycodeDecoder.jar:../lib/pfjgraphics.jar:../lib/QueryBuilder.jar:../lib/commons-collections-3.1.jar:../lib/commons-configuration-1.2.jar:../lib/commons-lang-2.1.jar:../lib/commons-logging.jar:../lib/com.ibm.icu_4.0.1.v20090822.jar:../lib/log4j.jar:../lib/xpp3.jar:../lib/jai_imageio.jar:../lib/logging.jar:../lib/com.azalea.ufl.barcode.1.0.jar:../lib/XMLConnector.jar:../lib/iText-5.0.1.jar:../lib/derby.jar:../lib/Xtreme.jar:../lib/icu4j-2.6.1.jar:../bin com.businessobjects.samples.CrystalExportExampleStrdrft /app/strdrft/sdReport/rpt/plrpt/$file /app/strdrft/sdReport/reports/$filename.pdf $user $passw "$P1" "$P2" $fl1 $db_name $server_name $port_num

#Check for Existance of generated report file before Starting the conversion process
if [ ! -f /app/strdrft/sdReport/reports/$filename.pdf ]
    then
        echo "Exception occured while Converting /app/strdrft/sdReport/reports/$filename.pdf to TXT file - PDF File not found.. Breaking out of Report Generation"
        exit 1
fi
echo "\n Converting to TXT"

/usr/local/bin/pdftotext -layout /app/strdrft/sdReport/reports/$filename.pdf /app/strdrft/sdReport/reports/$filename.txt

#Archive PDF file
cp /app/strdrft/sdReport/reports/$filename.pdf /app/strdrft/sdReport/reports/final/tmp/$filename"_"$DATE.pdf

#Check for Existance of converted report TXT file before Starting the Finalization process
if [ ! -f /app/strdrft/sdReport/reports/$filename.txt ]
    then
        echo "Exception occured while converting/finalizing the TXT file /app/strdrft/sdReport/reports/$filename.txt - File not found.. Breaking out of Report Finalization"
        exit 1
fi

cp /app/strdrft/sdReport/reports/$filename.txt /app/strdrft/sdReport/reports/final/tmp/$filename"_"$DATE.txt
done
dt1=`date`

echo "END Royal Bank Report : $dt1\n"
exit 0