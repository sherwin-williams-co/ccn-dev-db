#!/bin/sh
#################################################################
# Shell script to Archive the dailyLoad files created 
# for CUSTOMER_LABOR & STORE_DRAFT Files
# sxt410 06/19/2014
#################################################################
# below command will Archive CUSTOMER_LABOR & STORE_DRAFT Files.

. /app/ccn/host.sh

CUR_PATH="$HOME/initLoad/STORDRFT"

DATE=`date +"%m%d%Y"`

# Control will output if $DIRECTORY exists.
if [ -d "$CUR_PATH/archieve/"dailyLoad"_"$DATE"" ]; then
   echo " Directory exists "
else
  mkdir $CUR_PATH/archieve/"dailyLoad"_"$DATE"
  
fi


#Archive file for store_draft.
if 
    ls $CUR_PATH/STORE_DRAFT_*.TXT &> /dev/null; then
    echo " Store Draft files exist "
    find -maxdepth 1 -name STORE_DRAFT_\*.TXT -exec mv {} $CUR_PATH/archieve/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " Store Draft files doesn't exists "
fi

#Archive file for customer_labor.
if 
    ls $CUR_PATH/CUSTOMER_LABOR_*.TXT &> /dev/null; then
    echo " Customer Labor files exist "
    find -maxdepth 1 -name CUSTOMER_LABOR_\*.TXT -exec mv {} $CUR_PATH/archieve/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " Customer Labor files doesn't exists "
fi

echo " Archiving Completed "
exit 0
