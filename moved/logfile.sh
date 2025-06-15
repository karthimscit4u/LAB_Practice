#! /bin/bash
#Description 	: Script implemented for write the log function and call by other script.
#create on	    : 13th April 2025

#Revison History
#

# Set log file path
DATE=$(date +%d-%m-%y:%H%M%S)
LOG_FILE="/home/knh5cob/Learning/scripts/logs/myscript.log"
LOG_DIR="/home/knh5cob/Learning/scripts/logs/"
FILE="log_$DATE"
#environment details
host=$(hostname)
user=$(whoami)
timeofscript=$(date +%d-%m-%y:%T)
#Create log directory if not found
# Logging function
log_message() {
    local LOG_LEVEL=$1
    local MESSAGE=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$LOG_LEVEL] : $MESSAGE" >> "$LOG_FILE"
}

create_log_directory() {
    local CALLER_SCRIPT_NAME=$(basename "$1" .sh) 
    LOG_DIR_FIN="$LOG_DIR$CALLER_SCRIPT_NAME"
    
    # Create the log directory if it doesn't exist
    if mkdir -p "$LOG_DIR_FIN"; then
        LOG_FILE="$LOG_DIR_FIN/$FILE"
        log_message "INFO" "Directory '$LOG_DIR_FIN' created successfully."
            log_message "INFO" "Hostname is $host"
    log_message "INFO" "Script executed by $user"
    log_message "INFO" "Time of script execution $timeofscript"

    else
        log_message "ERROR" "Failed to create directory '$LOG_DIR_FIN'."
    fi
}




