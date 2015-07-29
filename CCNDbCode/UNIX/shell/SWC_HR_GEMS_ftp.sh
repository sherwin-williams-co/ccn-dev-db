######################################################################################
# Description     : Script to create CCN_GEMS_LOAD.TRG file and FTP to FLDPRRPT App server to run the reports
#
# Created by/Date : DXV848 05/07/2015
#######################################################################################
# below command will get the path for respective to the environment from which it runs from.
. /app/ccn/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

cd $HOME

#Generating the CCN_GEMS_LOAD.TRG file using the redirection command in FLDPRRT DB Server.
echo "Employee detail sync is done " > CCN_GEMS_LOAD.TRG

echo " Starting FTP Process to FLDPRRPT DB Server at $TIME on $DATE"
ftp -n ${dbfldserver_host} <<END_SCRIPT
quote USER ${dbfldserver_user}
quote PASS ${dbfldserver_pw}
cd ${fpr_dev_file_path}
put CCN_GEMS_LOAD.TRG
quit
END_SCRIPT

echo -e "\n End FTPing CCN_GEMS_LOAD.TRG file: Process Successful : Process finished at $TIME on $DATE"

TIME=`date +"%H:%M:%S"`
echo -e "\n Removing CCN_GEMS_LOAD.TRG file"
	rm -f CCN_GEMS_LOAD.TRG
TIME=`date +"%H:%M:%S"`	
echo -e "\n CCN_GEMS_LOAD.TRG file is removed"

exit 0

#############################################################
# END of PROGRAM.  
#############################################################
