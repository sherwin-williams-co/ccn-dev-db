

# report_Mainframe_FTP.csh
# Use to ftp to mainframe to be loaded to Mobius manframe


# Get the credentials for all applications from below file
# below command will get the path for fpr.config respective to the environment from which it is run from
. /app/ccn/host.sh

date=`date +"%Y%m%d%H%M%S"`

echo $HOME

# Move to STORDRFT from where ever you are in
cd $HOME/initLoad/STORDRFT

# ftp to mainframe to thier respective production name
#ftp -inv ${mainframe_host} <<FTP_MF
#quote user ${mainframe_user}
#quote pass ${mainframe_pw}

##quote SITE RECFM=FB,LRECL=100,BLKSIZE=27900,SPACE=(600,60),VOL(GDG350) TRACKS
#put Installer_1099_QRTLY  'SMIS1.STBD4060.ACCOUNT.EXCEL'
#bye
#END_SCRIPT
#echo "bye the transfer is complete"
#FTP_MF

#Archieve the bank files

 mv "Installer_1099_QRTLY" $HOME/initLoad/STORDRFT/archieve/1099_excel/Installer_1099_QRTLY"_"$date
 echo "Installer_1099_QRTLY has been archieved to $HOME/initLoad/STORDRFT/archieve/1099_excel/ path"

 
 exit 0


