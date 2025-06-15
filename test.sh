#! /bin/bash

###############################################################################
# Script Name   : Add your script Name
# Description   : Add script description
# Author        : KARTHIK
# Created Date  : 05-05-2025
# Modified Date : 05-05-2025
# Version       : 1.0
# Usage         : 
# Notes         : NA
###############################################################################
clear
#import log function
source ./loggenerator.sh

SCRIPT_FULLNAME="$(basename "$0")"
SCRIPT_PATH="$(realpath "$0")"
user=$(whoami)
timestamp=$(date +%d-%m-%Y:%H:%m:%S)
HOSTNAME=$(hostname)

#Basic Design of the script
info ""
info " Script Name : ${SCRIPT_FULLNAME} "
info " Path        : ${SCRIPT_PATH}"
info " Logged in user:$user"
info " Script execued on:$timestamp"
info " Hostname    : ${HOSTNAME}"


#Function

#Main Function
TO_EMAIL="karthik@example.com"
SUBJECT="MySQL Backup Status - $(date '+%F %T')"
./send_email.sh "$TO_EMAIL" "$SUBJECT" "$LOG_FILE"
