#!/bin/sh
#################################################################
# Script name   : exec_init_loads_str_terr_param.sh
# Description   : This shell script will call the script to  
#                 produce the init loads for store, terr and Param 
# Created       : rxv940 CCN Project Team.....
# Modified      : 
#################################################################
. /app/ccn/host.sh
#nohup sh /app/ccn/dev/exec_init_loads_str_terr_param.sh > /app/ccn/dev/datafiles/log/exec_init_loads_str_terr_param.log 2>&1 &
#ps -eaf | grep exec_init_loads_str_terr_param.sh

PROC_NAME="exec_init_loads_str_terr_param.sh";

DATADIR=$HOME/datafiles
ARCHIVEDIR=$DATADIR/polling/archive
ERRDIR=$DATADIR/polling/error

while(true)
do
    if [ $(ls "$DATADIR/"*".TRGFILE" 2>/dev/null | wc -l) -gt 0 ];    
    then
        #declarations

        TIME=`date +"%H%M%S"`
        DATE=`date +"%d%m%Y"`
        FILE="$DATADIR/COST_CENTER_DEQUEUE.TRGFILE"
    
        echo " $PROC_NAME --> Starting process at $DATE $TIME" 
        echo " $PROC_NAME --> Trigger File name is $FILE " 
        echo " $PROC_NAME --> Starting connection to DB at $DATE $TIME."

        ./call_to_init_loads_sql.sh

############################################################################
#            ARCHIVE AND ERROR STATUS CHECK
############################################################################
	
        # move the .trgfile file from DATADIR into ARCHIVEDIR
   
        mv $FILE $ARCHIVEDIR
        echo " $PROC_NAME --> $FILE file is archived successfully under $ARCHIVEDIR at $DATE $TIME " 
		
        status=$?
        if [ $status -ne 0 ]
        then
            TIME=`date +"%H:%M:%S"`
            echo " $PROC_NAME --> Failed when moving $FILE to $ARCHIVEDIR at $DATE $TIME " 
            mv "$FILE" "$ERRDIR"
            ./send_mail.sh "POLLING_FAILURE_MAIL" 
            exit 1
        fi		

        TIME=`date +"%H:%M:%S"`
        echo " $PROC_NAME --> Processing finished Successfully at $DATE $TIME " 

############################################################################
    
    fi
done

