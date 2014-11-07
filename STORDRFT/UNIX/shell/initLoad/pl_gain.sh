#!/bin/sh

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

echo "\n Converting to TXT"

/usr/local/bin/pdftotext -layout -nopgbrk /app/strdrft/sdReport/reports/$filename.pdf /app/strdrft/sdReport/reports/$filename.txt

sed  's/x/ /g' /app/strdrft/sdReport/reports/$filename.txt >  /app/strdrft/sdReport/reports/final/$filename.txt 


cp /app/strdrft/sdReport/reports/final/plreport.txt /app/strdrft/sdReport/reports/final/tmp/plreport_$DATE.txt

done
dt1=`date`

echo "END PL GAIN REPORT  : $dt1\n"
