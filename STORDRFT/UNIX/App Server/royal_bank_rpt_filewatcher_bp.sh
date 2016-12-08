#####################################################################################################################################
# Script name   : royal_bank_rpt_filewatcher_bp.csh
#
# Description   : This shell program will check if trg file exist
#                 IF trigger File exist then royal_bank_report.sh script will be executed.
#
# Created       : 11/21/2016 gxg192 CCN Project Team.....
# Modified      :
#
#####################################################################################################################################

datafiles_path="/app/strdrft/sdReport/reports"
trg_file_name="RUN_ROYAL_BANK_REPORT.TRG"

while true;
do
DATE=`date +"%m/%d/%Y"`
if [ -s $datafiles_path/$trg_file_name ]; then
    printf "\n $trg_file_name trigger file exist.\n"
    rm -f $datafiles_path/$trg_file_name
    printf "\n $trg_file_name trigger file removed.\n"
    
    TIME=`date +"%H:%M:%S"`
    printf "\n STARTED royal_bank_report.sh at $TIME on $DATE\n"
    ./royal_bank_report.sh

    status=$?
    TIME=`date +"%H:%M:%S"`
    
    if test $status -ne 0
    then
       printf "\n Processing FAILED for royal_bank_report.sh at ${TIME} on ${DATE}"
       exit 1;
    fi
    printf "\n Completed executing royal_bank_report.sh at ${TIME} on ${DATE}"
    
    printf "\n Finished executing royal_bank_rpt_filewatcher : Processing Finished at $TIME on $DATE \n"
fi
done

#############################################################
# END of PROGRAM.
#############################################################
