#!/bin/sh
#################################################################
# Script name   : SRA11000_initload.sh #
# Description   : This shell script will perform all the init load process
#
# Created  : 03/04/2016 dxv848/nxk927 CCN Project Team.....
# Modified : 
#################################################################
. /app/banking/dev/banking.config

proc_name="Initload"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"
while true;
do
#################################################################
# Check if the  SRA10510_D*.TXT ,SRA13510_D*.TXT ,SRA11060_D*.TXT
#################################################################
    cd $DATA_FILES_PATH
	file_name=SRA10510_D*.TXT
    file_name1=SRA13510_D*.TXT
    file_name2=SRA11060_D*.TXT
    if [ -e $file_name ] && [ -e $file_name1 ] && [ -e $file_name2 ]; then
        echo "The $file_name ,$file_name1 , $file_name2 is exists\n "
        file=`ls -1t SRA10510_D*.TXT |tail -1`
	    file1=`ls -1t SRA13510_D*.TXT |tail -1`
	    file2=`ls -1t SRA11060_D*.TXT |tail -1`

        dt1=${file:10:6}
        dt2=${file1:10:6}
        dt3=${file2:10:6}
        echo $dt1
        echo $dt2
        echo $dt3

#################################################################
#Check if the  all the files has same date and make the directory
#################################################################		
        if [ "$dt1" == "$dt2" ] && [ "$dt2" == "$dt3" ];
        then
            echo "All the 3 files has same date \n "
            if [ -d "$ARCHIVE_PATH/$dt1" ]; then
                echo "Directory $ARCHIVE_PATH/$dt1 exists"
            else
                echo "Directory $ARCHIVE_PATH/$dt1 does not exists, creating one. . ."
                mkdir $ARCHIVE_PATH/$dt1
            fi
#################################################################
#                            rename the files for load processing
#################################################################	
            echo "Process Started to renaming $file  \n"
            cat $file >> SRA10510.TXT
            echo "Process Finished to renaming $file \n"
      
            echo "Process Started to renaming $file1  \n"
            cat $file1 >> SRA13510.TXT
            echo "Process Finished to renaming $file1 \n"

            echo "Process Started to renaming $file2  \n"
            cat $file2 >> SRA11060.TXT
            echo "Process Finished to renaming $file2 \n"

#################################################################
#                               archive the input files to folder
#################################################################
            echo "Process Started to archive the $file to $dt1 folder \n"
            mv $file $ARCHIVE_PATH/$dt1
            echo "Process Finished to archive the $file to $dt1 folder \n"

            echo "Process Started to archive the $file1 to $dt1 folder \n"
            mv $file1 $ARCHIVE_PATH/$dt1
            echo "Process Finished to archive the $file1 to $dt1 folder \n"

            echo "Process Started to archive the $file2 to $dt1 folder \n"
            mv $file2 $ARCHIVE_PATH/$dt1
            echo "Process Finished to archive the $file2 to $dt1 folder \n"

            cd $HOME
#################################################################
#                                    run the Process to load data
#################################################################  
echo "Processing Started to load tables at $TIME on $DATE"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<EOF > $LOGDIR/SQLlog_$dt1.log
set heading off;
set serveroutput on;
set verify off;
@SUMMARY.sql "to_date('$dt1','YYMMDD')"
@JV_EXTRCT.sql "to_date('$dt1','YYMMDD')"
@ACH_DRAFT.sql "to_date('$dt1','YYMMDD')"

exit;
EOF
TIME=`date +"%H:%M:%S"`
status=$?
         if test $status -ne 0
         then
             echo "processing FAILED to load SRA13510 , SRA10510  and at ${TIME} on ${DATE}"
             exit 1;
         fi

echo "Processing finished for loading data at $dt1 at $TIME on $DATE"

#################################################################
#                             move the rename files to the folder
#################################################################
            echo "Process Started to archive the SRA10510.TXT to $dt1 folder \n"
            mv $DATA_FILES_PATH/SRA10510.TXT $ARCHIVE_PATH/$dt1
            echo "Process Finished to archive the SRA10510.TXT to $dt1 folder \n"

			echo "Process Started to archive the SRA13510.TXT to $dt1 folder \n"
            mv $DATA_FILES_PATH/SRA13510.TXT $ARCHIVE_PATH/$dt1
            echo "Process Finished to archive the SRA13510.TXT to $dt1 folder \n"

			echo "Process Started to archive the SRA11060.TXT to $dt1 folder \n"
            mv $DATA_FILES_PATH/SRA11060.TXT $ARCHIVE_PATH/$dt1
            echo "Process Finished to archive the SRA11060.TXT to $dt1 folder \n"

            TIME=`date +"%H:%M:%S"`
            echo "process completed for $dt1 at $TIME"
        else
		echo "all 3 files does not have same date $dt1 send email"
#################################################################
#               SEND email if the 3 files does not have same date
#################################################################
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << END
set heading off;
set verify off;
execute MAIL_PKG.send_mail('SRA11000_PROCESS',null,null); 
exit;
END
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
    echo "processing FAILED for Sending Mail at ${TIME} on ${DATE}"
    exit 1;
fi
        exit 0
        fi
    else
        echo "There is no files to load Process Done successfully "
        exit 0
    fi
done
exit 0
#################################################################
#                Process END 
################################################################# 
