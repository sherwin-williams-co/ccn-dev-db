#!/bin/sh
###################################################################################################################################
# Script name   : Archive_all_temp.sh (BANKING-APP Server)
#
# Description   : This shell program will Archive All file's from the log folder.
#                 This shell runs every 1st of the month to archive all the temporary files to archive folder by year/month.
# Created       : 10/25/2017 sxg151
#
###################################################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

base_dir="$HOME"

cd $base_dir
        echo "Get the file ext from config file"
 
   for file_ext in `cat archive_all_temp.config`
   do       
      for file in `find . -name .snapshot -prune  -o -name 'archive' -prune -prune -o -name "$file_ext" -print`
      do 
          #Get a New Directory name from log file timestamp
         dir_year=`perl -MPOSIX -le 'print strftime "%Y",localtime     ((lstat)[9]) for @ARGV' $file`
         dir_month=`perl -MPOSIX -le 'print strftime "%B",localtime     ((lstat)[9]) for @ARGV' $file`

         dir_year="$base_dir/archive/$dir_year"
         dir_month="$dir_year/$dir_month"

         echo "create a new directory If it not exist:$dir_month"

          if [ ! -d $dir_year ];  then
             # create the directory
             mkdir -p $dir_year
             echo "Year-Directory created : $dir_year"
          fi
          if  [ ! -d $dir_month ];  then
             # create the directory
             mkdir -p $dir_month
             echo "Month-Directory created-MONTH : $dir_month"
          fi
          if  [ -e $file ]; then
             mv $file $dir_month
             echo " File : $file has been moved to $dir_month"
          fi
        done
    done

 exit 0
######################################################################################################################################
# END of PROGRAM.
######################################################################################################################################
