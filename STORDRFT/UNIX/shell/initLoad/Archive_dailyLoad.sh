#!/bin/sh
#################################################################
# Shell script to Archive the dailyLoad files created 
# for CUSTOMER_LABOR & STORE_DRAFT Files
# sxt410 06/19/2014
#################################################################
# below command will Archive CUSTOMER_LABOR & STORE_DRAFT Files.

. /app/stordrft/host.sh

DATE=`date +"%m%d%Y"`

mkdir $HOME/dailyLoad/archieve/"dailyLoad"_"$DATE"

#Archive file for store_draft.
if 
    ls $HOME/dailyLoad/STORE_DRAFT_*.TXT &> /dev/null; then
    echo " Store Draft files exist "
    find -name STORE_DRAFT_\*.TXT -exec mv {} $HOME/dailyLoad/archieve/"dailyLoad"_"$DATE" \;
else
    echo " Store Draft files doesn't exists "
fi

#Archive file for customer_labor.
if 
    ls $HOME/dailyLoad/CUSTOMER_LABOR_*.TXT &> /dev/null; then
    echo " Customer Labor files exist "
    find -name CUSTOMER_LABOR_\*.TXT -exec mv {} $HOME/dailyLoad/archieve/"dailyLoad"_"$DATE" \;
else
    echo " Customer Labor files doesn't exists "
fi

echo " Archiving Completed "
exit 0
