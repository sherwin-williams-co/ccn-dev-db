#################################################################
# Script name   : SRA11000_FL_LW_ENV_FTP.sh
#
# Description   : Checks for the file  SRA10510_*.TXT, SRA13510_*.TXT, SRA11060_*.TXT and UAR.MISCTRAN_*.TXT
#                 If it find all the four files,it ftp's all the file 
#                 We are receiving the SRA11000 input files in QA and prod. TO make it run in test, this script wil ftp
#                 the input files to test.
# Created       : 04/07/2017 nxk927 CCN Project Team.....
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#path where the Command file is stored
FOLDER=`date +"%m%d%Y"`
FILES_PATH=$HOME/SRA11000/$FOLDER
# Search for the file named SRA10510_*.TXT,SRA10910_*.TXT, UAR.MISCTRAN_*.TXT, UAR.OVERSHRT_*.TXT

cd $FILES_PATH
if [ -e SRA10510_D*.TXT ] && [ -e SRA10910_D*.TXT ] && [ -e UAR.MISCTRAN_D*.TXT ] && [ -e UAR.OVERSHRT_D*.TXT ]; then
ftp -inv ${BANKING_HOST} <<FTP_MF
quote user ${BANKING_USER}
quote pass ${BANKING_PW}
cd "/app/banking/test/initLoad"
put SRA10510_D*.TXT
put SRA10910_D*.TXT
put UAR.MISCTRAN_D*.TXT
put UAR.OVERSHRT_D*.TXT
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF
fi

echo "FTP process completed"


