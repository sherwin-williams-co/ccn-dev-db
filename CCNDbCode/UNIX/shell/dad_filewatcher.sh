#!/bin/sh
#########################################################################################
# Script Name    :  dad_filewatcher.sh
#
# Description    :  This shell program will search for the STFF1002_*.TXT file when ever 
#                   comparison file is placed on the ccn db server by the mainframe and
#                   when file is found it invokes the ccn_sd_dad_comparison.sh script
# Created        :  AXK326 05/15/2015
# Modified       :  AXK326 06/11/2015 
#                   Modified script to find the file with the name STFF1002.TXT
#########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="DAD_FILEWATCHER"
 dad_file_path="$HOME/initLoad"
 dad_path="$HOME/batchJobs"
 
 # Search for the file named STFF1002.TXT 
while true; 
do
   if [ -s $dad_file_path/STFF1002.TXT ]
   then
      echo "file found \n"
      echo "process started for $proc to load the dad values \n"	  
	  cd $dad_path
      ./ccn_dad_load_process.sh
	  ./ccn_dad_archive.sh
   fi
done

echo "process completed for $proc - but should not come to this point"
