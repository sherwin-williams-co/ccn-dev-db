#!/bin/sh

##############################################################################################
# Script Name   :  POS_XML_FILE_MAIN (Control-M)
#
# Description    :  This shell program POS_XML_FILES  
#
# This shell program will initiate load data into our local table and the creation of the pos_file_gen file, 
#archieve it and  FTP'd to the mainframe using the following modules:
#    
#                POS_XML_IFACE_LOCAL.sh  -->  data loaded into POS_XML_IFACE_LOCAL File
#                pos_file_gen.sh   -->  Generate the pos_file_gen file
#                ftp_mq_convert_file.sh --> Ftp to main frame
#                archive_pos_file.sh -> archive the pos file
#
# Created           :  dxv 09/21/2015
#
##############################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 BACKFEED_PATH="$HOME/batchJobs/backFeed/"
 cd $BACKFEED_PATH

echo "Processing Started for POS_XML_FILE_MAIN.sh process at ${TIME} on ${DATE}"
############################################################################
#         execute pos_xml_iface_local.sh date loaded into table
############################################################################
echo "Processing Started for pos_xml_iface_local.sh  at ${TIME} on ${DATE}"
./pos_xml_iface_local.sh


#############################################
#   ERROR STATUS CHECK  POS_XML_IFACE_LOCAL shell
#############################################
status=$?
if test $status -ne 0 
   then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for pos_xml_iface_local.sh at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for pos_xml_iface_local.sh at ${TIME} on ${DATE}"

#############################################################################
#  Execute pos_file_gen.sh to Generate pos_file 
##############################################################################
echo "pos_file_gen.sh  Started at ${TIME} on ${DATE}"
./pos_file_gen.sh

##############################################
#    ERROR STATUS CHECK pos_file_gen.sh 
##############################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for pos_file_gen.sh at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for pos_file_gen.sh at ${TIME} on ${DATE}"

############################################################################
#   execute ftp_mq_convert_file.sh shell to send pos_file File to Mainframe
############################################################################
echo "Processing Started for ftp_mq_convert_file.sh  at ${TIME} on ${DATE}"
./ftp_mq_convert_file.sh

##############################################
#    ERROR STATUS CHECK ftp_mq_convert_file shell
##############################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for ftp_mq_convert_file.sh at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for ftp_mq_convert_file.sh at ${TIME} on ${DATE}"

##############################################################################
#  Execute archive_pos_file.sh to Concatenate all the files in order to send to MF
##############################################################################
echo "archive_pos_file.sh  Started at ${TIME} on ${DATE}"
./archive_pos_file.sh

##############################################
#    ERROR STATUS CHECK archive_pos_file.sh 
##############################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for archive_pos_file.sh at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for archive_pos_file.sh at ${TIME} on ${DATE}"
echo "Processing finished for POS_XML_FILE_MAIN.sh process at ${TIME} on ${DATE}"  

exit 0

############################################################################
#                     END  of  PROGRAM  
############################################################################

