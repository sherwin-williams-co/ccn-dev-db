#!/bin/sh
####################################################################################################
# Script name: remove_crtmp.sh
# Description: Script for delete crystal report temp files created in /var/tmp Directory.
# Date: 07/17/2017
# Created: pxb712 ccn project team..
####################################################################################################

echo "\n Removing Crystal report temp files \n"

find  /var/tmp/*.crtmp -type f -exec rm -f {} \;

echo "\n Removing Process is Completed \n"

exit 0