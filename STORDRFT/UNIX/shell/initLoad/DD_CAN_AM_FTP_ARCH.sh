# report_Mainframe_FTP.csh
# Use to ftp to mainframe to be loaded to Mobius manframe

# Get the credentials for all applications from below file
# below command will get the path for fpr.config respective to the environment from which it is run from
. /app/ccn/host.sh

date=`date +"%Y%m%d%H%M%S"`

# Move to datafiles from where ever you are in
cd $HOME/initLoad/STORDRFT

# ftp to mainframe to thier respective production name
#ftp -inv ${mainframe_host} <<FTP_MF
#quote user ${mainframe_user}
#quote pass ${mainframe_pw}
#
###quote SITE RECFM=FB,LRECL=100,BLKSIZE=27900,SPACE=(600,60),VOL(GDG350) TRACKS
#put DLY_DRAFT_CAN_AM  'SMIS1.STBD1360'
#
#bye
#END_SCRIPT
#echo "bye the transfer is complete"
#FTP_MF

#Archieve the bank files

mv "DLY_DRAFT_CAN_AM" $HOME/initLoad/STORDRFT/archieve/Daily_bank/DLY_DRAFT_CAN_AM"_"$date
echo "DLY_DRAFT_CAN_AM has been archieved to $HOME/initLoad/STORDRFT/archieve/Daily_bank/ path"

#################################################
#    ERROR STATUS CHECK DD_CAN_AM_FTP_ARCH.sh 
#################################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for DD_CAN_AM_FTP_ARCH at ${TIME} on ${DATE}"
     exit 1;
fi

exit 0
