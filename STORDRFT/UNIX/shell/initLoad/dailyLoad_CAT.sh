#!/bin/sh
#################################################################
# Shell script to concatenate the dailyLoad files created 
# axk326 06/19/2014
#
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

CUR_PATH="$HOME/dailyLoad"

DATE=`date +"%m%d%Y"`

if ls $HOME/dailyLoad/CUSTOMER_LABOR_*.TXT &> /dev/null; 
  then
     echo "  CUSTOMER files exists "
	 cd $CUR_PATH
	 echo "  concatenating customer datafiles"
	 cat /dev/null > CUSTOMER_LABOR.TXT
	 cat $CUR_PATH/CUSTOMER_LABOR_*.TXT >> $CUR_PATH/CUSTOMER_LABOR.TXT
	else
	  echo "  Customer files do not exist "
      cat /dev/null > CUSTOMER_LABOR.TXT
fi

if ls $HOME/dailyLoad/STORE_DRAFT_*.TXT &> /dev/null; 
  then
     echo "  StoreDraft files exists "
	 cd $CUR_PATH
	 echo "  concatenating StoreDraft datafiles"
	 cat /dev/null > STORE_DRAFT.TXT
	 cat $CUR_PATH/STORE_DRAFT_*.TXT >> $CUR_PATH/STORE_DRAFT.TXT
	else
	  echo "  StoreDraft files do not exist "
      cat /dev/null > STORE_DRAFT.TXT
fi
	echo "  Done Concatenating files "

exit 0