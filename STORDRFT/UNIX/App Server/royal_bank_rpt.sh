#!/bin/sh
#######################################################################
# Script Name : royal_bank_rpt.sh
# Description : This Shell Script Runs the crystal report
#               for royal banking and converts pdf file to
#               text file.
# Created     : 10/18/2016 MXR916
# Modified    : 12/08/2016 gxg192 report name is fetched in this script
#                          instead of passing as parameter
#             : 01/05/2017 gxg192 Added comments regarding report file
########################################################################
. /app/strdrft/dataloadInfo.txt

user=$sqlplus_user
passw=$sqlplus_pw

dt=`date`
echo "START Royal Bank Report : $dt\n"

rep1=`cat /app/strdrft/sdReport/data/run2.txt` 
fl1="1"

P1=`cat /app/strdrft/sdReport/data/param.lst|cut -d"|" -f1`
P2=`cat /app/strdrft/sdReport/data/param.lst|cut -d"|" -f2`

for file in $rep1
do

echo "Running $file"

filename=`basename $file .rpt` 
PATH=/usr/jdk/jdk1.7.0_17/bin:$PATH

#############################################################################################
#  Below command executes Royal_Bank_Report.rpt file that has main report and a subreport.
#  Main report displays summary and details data for all the transit types except 05
#  Subreport displays data for transit type as 05.
#############################################################################################

java -classpath .:../src:../lib/cvom.jar:../lib/log4j-1.2.14.jar:../lib/CrystalReportsRuntime.jar:../lib/ojdbc5-11.1.0.7.0.jar:../lib/CrystalCommon2.jar:../lib/DatabaseConnectors.jar:../lib/JDBInterface.jar:../lib/keycodeDecoder.jar:../lib/pfjgraphics.jar:../lib/QueryBuilder.jar:../lib/commons-collections-3.1.jar:../lib/commons-configuration-1.2.jar:../lib/commons-lang-2.1.jar:../lib/commons-logging.jar:../lib/com.ibm.icu_4.0.1.v20090822.jar:../lib/log4j.jar:../lib/xpp3.jar:../lib/jai_imageio.jar:../lib/logging.jar:../lib/com.azalea.ufl.barcode.1.0.jar:../lib/XMLConnector.jar:../lib/iText-5.0.1.jar:../lib/derby.jar:../lib/Xtreme.jar:../lib/icu4j-2.6.1.jar:../bin com.businessobjects.samples.CrystalExportExampleStrdrft /app/strdrft/sdReport/rpt/plrpt/$file /app/strdrft/sdReport/reports/$filename.pdf $user $passw "$P1" "$P2" $fl1 $db_name $server_name $port_num

echo "\n Converting to TXT"

/usr/local/bin/pdftotext -layout -nopgbrk /app/strdrft/sdReport/reports/$filename.pdf /app/strdrft/sdReport/reports/$filename.txt

sed  's/x/ /g' /app/strdrft/sdReport/reports/$filename.txt >  /app/strdrft/sdReport/reports/final/$filename.txt 

done
dt1=`date`

echo "END Royal Bank Report : $dt1\n"
