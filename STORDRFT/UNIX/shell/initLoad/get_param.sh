

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

echo "Begin Get Parmaeters"

##setting up the parameters to run
A=`date --date -d +01/%m/%Y`

#writing the parameters in the param.lst file
echo "$A" >> $HOME/Reports/param.lst


echo "End Get Parameters"

exit 0
