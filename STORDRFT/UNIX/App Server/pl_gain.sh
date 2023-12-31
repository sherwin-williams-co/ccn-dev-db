#!/bin/sh
##########################################################
# Script to Run the reports
#
# modified: 05/09/2017 rxa457 - asp-781 CCN Project Team... 
# Added Script Comments and Handled exceptions 
# modified: 01/09/2018 nxk927
#           removed the sed command from this script to concatinate the files before using sed to strip 'x'
#           as this was creating page break issue.
##########################################################

. /app/strdrft/dataloadInfo.txt

dt=`date`
DATE=`date +"%m-%d-%Y-%H%M%S"`
echo "START PL GAIN REPORT : $dt\n"

user=$sqlplus_user
passw=$sqlplus_pw
run=`cat $1`
fl1="1"
P1=`cat /app/strdrft/sdReport/data/param.lst|cut -d"|" -f1`
P2=`cat /app/strdrft/sdReport/data/param.lst|cut -d"|" -f2`

for file in $run
do

echo "Running $file"

filename=`basename $file .rpt` 

PATH=/usr/jdk/jdk1.7.0_17/bin:$PATH
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

echo "END PL GAIN REPORT  : $dt1\n"

exit 0
