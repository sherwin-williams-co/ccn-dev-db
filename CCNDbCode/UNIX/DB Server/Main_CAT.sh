#!/bin/sh
#################################################################
# Script name   : Main_Cat.sh
#
# Description   : Script to copy/concatenate the backfeed files 
#		  and the Banking backfeed files together
# Created  	  : 09/16/2015 sxh487 CCN Project Team.....
#
#################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

CCN_PATH="$HOME/batchJobs/backFeed/current"
LOG_PATH="$HOME/batchJobs/backFeed/logs"

ccn_fname="Costcntr_backfeed.txt"
cdate=`date +'%Y%m%d%H%M%S'`

#copy Audit_backfeed.txt to as Costcntr_backfeed.txt
echo "\n Copying Audit_backfeed file \n"
cp $CCN_PATH/Audit_backfeed.txt $LOG_PATH/$ccn_fname"_"$cdate

#concatenate Audit_backfeed.txt and Banking_backfeed.txt into Audit_backfeed.txt
echo "Concatenating the files "
cat $CCN_PATH/Banking_audit.txt >> $CCN_PATH/Audit_backfeed.txt
echo " Done Concatenating files "


