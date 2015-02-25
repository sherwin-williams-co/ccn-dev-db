#! /bin/sh

# plgain_FTP.sh
# Use to ftp to mainframe to be loaded to Mobius manframe

. /app/strdrft/dataloadInfo.txt

cd /app/strdrft/sdReport/reports/final

# ftp to mainframe
ftp -n ${mainframe_host} <<FTP_MF
quote USER ${mainframe_user}
quote PASS ${mainframe_pw}
put glreport.txt 'STST.STBD3340(+1)'

bye
FTP_MF

exit 0