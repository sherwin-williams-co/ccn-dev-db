#!/bin/sh
###################################################################################
# Script name   : descartes_hrchy_file_dailyrun.sh
#
# Description   : This is Wrapper script which performs below tasks
#                 1. Generates the Descartes Hierarchy Details Feed (pipe delimited)
#                 2. FTP's the output file
#                 3. Archives the generated output file
#
# Created  : 09/29/2017 rxa457 CCN Project Team
# Modified : 10/26/2017 nxk927 CCN Project Team
#            added the error handling if there is error in any scripts
###################################################################################
# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/host.sh

proc_name="descartes_hrchy_file_dailyrun"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

###################################################################################
#                  Generate the descartes HRCHY output file
###################################################################################
sh /app/ccn/dev/batchJobs/descartes_hrchy_file_generate.sh


############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   exit 1;
fi
###################################################################################
#         FTP descartes HRCHY output file
###################################################################################
sh /app/ccn/dev/batchJobs/descartes_hrchy_file_ftp.sh

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   exit 1;
fi

###################################################################################
#         Archiving descartes HRCHY output file file
###################################################################################
sh /app/ccn/dev/batchJobs/descartes_hrchy_file_arch.sh

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at $TIME on $DATE"
exit 0
###################################################################################
#                Process END
###################################################################################
