#! /bin/bash

###############################################################################
# Script Name   : Monitor the Disk Utilization
# Description   : Script will be monitor the / mount point reached 40% trigger the email 
# Author        : KARTHIK
# Created Date  : 13-06-2025
# Modified Date : 13-06-2025
# Version       : 1.0
# Usage         : ./
# Notes         : NA

###############################################################################
clear
#import log function
source ./loggenerator.sh

SCRIPT_FULLNAME="$(basename "$0")"
SCRIPT_PATH="$(realpath "$0")"
SCRIPT_PATH_ONLY="$(dirname "$(realpath "$0")")"
user=$(whoami)
timestamp=$(date +%d-%m-%Y:%H:%m:%S)
HOSTNAME=$(hostname)
LOG_FILES="$SCRIPT_PATH_ONLY/$LOG_FILE"


#Basic Design of the script
info ""
info " Script Name : ${SCRIPT_FULLNAME} "
info " Path        : ${SCRIPT_PATH}"
info " Logged in user:$user"
info " Script execued on:$timestamp"
info " Hostname    : ${HOSTNAME}"
info " Log Captured: ${LOG_FILES}"
info " ========================"
info " "
#Variable Declaration

#GET_DISK_SIZE="$(df -h | awk 'NR==1 || /\/dev\/nvme0n1p3/')"
#info  "${GET_DISK_SIZE}"
#Function

#Main Function

GET_DISK_SIZE="$(df -h | awk '$1 == "/dev/nvme0n1p3" { print $5 }')"
GET_DISK_SIZE=${GET_DISK_SIZE%\%}

#echo $GET_DISK_SIZE

if [ "$GET_DISK_SIZE" -gt "40" ]; then
    info "Disk usage is reached threshold: $GET_DISK_SIZE"
#else
    #echo "Device $DEVICE not found in df output."
fi