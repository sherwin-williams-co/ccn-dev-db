#!/bin/sh
###################################################################################################################################
# Script name   : Archive_all_temp.sh
#
# Description   : This shell program will Archive All file's from the log folder.
#                 This shell runs every 1st of the month to archive all the temporary files to archive folder by year/month.
# Created       : 10/25/2017 sxg151
# 
###################################################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from

. /app/ccn/host.sh

# Debug
# set -x

save_dir=`date +%B-%Y`

base_dir="$HOME"
#base_dir="/app/ccn/dev/Test"

cd $base_dir

# Find all directories in corrent Location :

#for dir_one in `ls -l |grep ^d |grep -vi scripts |awk '{print $NF}'`
 for dir_one in `ls -l |grep ^d |grep -vi archive|awk '{print $NF}'`
do
       cd "$base_dir/$dir_one"

           for file in `find . -name archive -prune -o \( -name '*.log' -o -name 'cmd_start*.sh' -o -name '*.csv' -o -name '*.dat' \) -print`
           #for file in `find . -name .archive -prune -o -name '*log' -print`

       do
               #Create a New Directory with log file timestamp

               save_dir=`perl -MPOSIX -le 'print strftime "%B-%Y",
          localtime((lstat)[9]) for @ARGV' $file`
               dir_two="$base_dir/archive/$save_dir"
               
echo "create the new directory If it not exist:$save_dir"

            # Create an archive directory if not exist

               if [ ! -d $dir_two ];  then
               # create the directory
                       mkdir -p $dir_two

      echo "Directory created : $dir_two"
               fi


               if [ -e $file ]; then
               #Move the files to archive
                       mv $file $dir_two
echo " File : $file has been moved to $dir_two"     
                                    
                                 
               fi

       
       done

done

exit 0

######################################################################################################################################
# END of PROGRAM.  
######################################################################################################################################
 