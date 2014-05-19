#!/bin/sh

# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config

cd $HOME/datafiles

# ftp to mainframe
file_name=$1

ftpResult=`ftp -n ${mainframe_host} <<FTP_MF
quote USER ${mainframe_user}
quote PASS ${mainframe_pw}
quote SITE RECFM=FB,LRECL=438,BLKSIZE=27594,SPACE=(600,60),VOL(GDG354) TRACKS
put "$file_name" 'STST.(+1)'

bye
FTP_MF`
