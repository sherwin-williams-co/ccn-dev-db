#!/bin/sh
###################################################################################
# Script name   : descartes_dailyRun.sh
#
# Description   : This is Wrapper script which performs below tasks
#                 1. Generates the Descartes Hierarchy Details Feed (pipe delimited)
#                 2. FTP's the output file
#                 3. Archives the generated output file
#
# Created  : 09/29/2017 rxa457 CCN Project Team
###################################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc_name="descartes_dailyRun"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

###################################################################################
#                  Generate the descartes HRCHY output file
###################################################################################
./generate_descartes_hrchy_file.sh

###################################################################################
#         FTP descartes HRCHY output file
###################################################################################
./descartes_hrchy_file_dailyRun_ftp.sh

###################################################################################
#         Archiving descartes HRCHY output file file
###################################################################################
./descartes_arch_hrchy_file.sh

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at $TIME on $DATE"
exit 0
###################################################################################
#                Process END
###################################################################################
