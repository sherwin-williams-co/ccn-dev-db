#!/bin/sh
#################################################################
# Script name   : SRA11000_dailyRun.sh
#
# Description   : This shell script will perform below tasks
#                 1. rename the files accordingly to be used for the process
#                 2. invoke the procedure that performs the core process
#                 3. archieve the files in it's corresponding folder
#
# Created  : 08/04/2015 jxc517 CCN Project Team.....
# Modified : 10/16/2015 jxc517 CCN Project Team.....
#            added the FTP call before archiving
#          : 01/06/2016 nxk927 CCN Project Team.....
#            changed mv to cat command. If we recieve multiple files then 
#            mv command will fail. cat will concatenate the files to one file and 
#            the process won't fail. 
#            Also archiving all the original files in the same folder as well.
#          : 02/26/2016 nxk927/dxv848 CCN Project Team.....
#            Archiving scripts called to archive the input files   
#          : 03/03/2016 dxv848/nxk927 CCn project Team.....
#            created separate scripts
#            1.concatenate the input files then move only input files to archive folder-- SRA11000_Archinput_file.sh
#            2. move the concatenate files to archive folder after the core process done -- SRA11000_Archconcat_file.sh
#          : 04/27/2016 nxk927 CCN Project Team.....
#            pushed the time variable inside in teh error check so the error check can be handled properly
#            updated the error check
#          : 01/11/2017 gxg192 The status check at the end of the file is removed as it is not required
#          : 07/27/2017 nxk927
#            Process to load data and generate the output file splitted in two process
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_dailyRun"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#          Control will output if directory with that date exists
#################################################################
if [ -d "$ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $ARCHIVE_PATH/$FOLDER
fi

#################################################################
#                                          Rename the input files
#################################################################

./SRA11000_Rename_file.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for SRA11000_Rename_file script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA11000_Rename_file script at ${TIME} on ${DATE}"

#################################################################
#                          archive input files to archive folder
#################################################################

./SRA11000_Archinput_file.sh
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for SRA11000_Archinput_file script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA11000_Archinput_file script at ${TIME} on ${DATE}"

#################################################################
#                  STR_BNK_DPST_DLY_RCNCL_PROCESS.LOAD_DATA
#################################################################
echo "Processing started for UAR data load for the uar.position file and serial.dat file at ${TIME} on ${DATE}"
./SRA11000_load_data.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for UAR data load for the uar.position file and serial.dat file at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for UAR data load for the uar.position file and serial.dat file at ${TIME} on ${DATE}"

#################################################################
#                  STR_BNK_DPST_DLY_RCNCL_PROCESS.GENERATE_FILES
#################################################################
echo "Processing started for generating uar.position file and serial.dat file at ${TIME} on ${DATE}"
./SRA11000_generate_files.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for generating uar.position file and serial.dat file at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for generating uar.position file and serial.dat file at ${TIME} on ${DATE}"


#################################################################
#                 Archive the concatenate files to archive folder
#################################################################

./SRA11000_Archconcat_file.sh
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for SRA11000_Archconcat_file script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA11000_Archconcat_file script at ${TIME} on ${DATE}"

#################################################################
#         FTP files SMIS1.SRA12060_*, SMIS1.SRA10060_*
#################################################################
./SRA11000_dailyRun_ftp.sh
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for SRA11000_dailyRun_ftp at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA11000_dailyRun_ftp at ${TIME} on ${DATE}"

#################################################################
#         ARCHIVE files SMIS1.SRA12060_*, SMIS1.SRA10060_*
#################################################################
./SRA11000_Arch_Output_file.sh
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for SRA11000_Arch_Output_file script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA11000_Arch_Output_file script at ${TIME} on ${DATE}"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
