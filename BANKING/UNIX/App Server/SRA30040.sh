#!/bin/sh
##########################################################
# Script to Run the reports
#
# modified: 08/23/2017 nxk927 CCN Project Team... 
# Added Script Comments and Handled exceptions 
##########################################################

. /app/banking/dev/banking.config

dt=`date`
DATE=`date +"%m-%d-%Y-%H%M%S"`
echo "START SRA30040 REPORT : $dt\n"

user=$banking_sqlplus_user
passw=$banking_sqlplus_pw
run=`cat $1`
fl1="1"
P1=`cat /app/banking/dev/report/data/param.lst|cut -d"|" -f2`
P2=`cat /app/banking/dev/report/data/param.lst|cut -d"|" -f2`

for file in $run
do

echo "Running $file"

filename=`basename $file .rpt` 

PATH=/usr/jdk/jdk1.7.0_17/bin:$PATH
java -classpath .:../src:../lib/cvom.jar:../lib/log4j-1.2.14.jar:../lib/CrystalReportsRuntime.jar:../lib/ojdbc5-11.1.0.7.0.jar:../lib/CrystalCommon2.jar:../lib/DatabaseConnectors.jar:../lib/JDBInterface.jar:../lib/keycodeDecoder.jar:../lib/pfjgraphics.jar:../lib/QueryBuilder.jar:../lib/commons-collections-3.1.jar:../lib/commons-configuration-1.2.jar:../lib/commons-lang-2.1.jar:../lib/commons-logging.jar:../lib/com.ibm.icu_4.0.1.v20090822.jar:../lib/log4j.jar:../lib/xpp3.jar:../lib/jai_imageio.jar:../lib/logging.jar:../lib/com.azalea.ufl.barcode.1.0.jar:../lib/XMLConnector.jar:../lib/iText-5.0.1.jar:../lib/derby.jar:../lib/Xtreme.jar:../lib/icu4j-2.6.1.jar:../bin com.businessobjects.samples.CrystalExportExampleStrdrft /app/banking/dev/report/rpt/$file /app/banking/dev/report/reports/$filename.pdf $user $passw "$P1" "$P2" $fl1 $db_name $server_name $port_num

#Check for Existance of generated report file before Starting the conversion process
if [ ! -f /app/banking/dev/report/reports/$filename.pdf ]
    then
        echo "Exception occured while Converting /app/banking/dev/report/reports/$filename.pdf to TXT file - PDF File not found.. Breaking out of Report Generation"
        exit 1
fi

echo "\n Converting to TXT"


#Archive PDF file
cp /app/banking/dev/report/reports/$filename.pdf /app/banking/dev/report/reports/current/archive/$filename"_"$DATE.pdf

#Check for Existance of converted report TXT file before Starting the currentization process
if [ ! -f /app/banking/dev/report/reports/$filename.pdf ]
    then
        echo "Exception occured while converting/currentizing the TXT file /app/banking/dev/report/reports/$filename.txt - File not found.. Breaking out of Report currentization"
        exit 1
fi

cp /app/banking/dev/report/reports/$filename.pdf /app/banking/dev/datafiles/$filename.pdf
cp /app/banking/dev/report/reports/$filename.pdf /app/banking/dev/report/reports/current/archive/$filename"_"$DATE.pdf

done
dt1=`date`

echo "END SRA30040 REPORT  : $dt1\n"

exit 0
