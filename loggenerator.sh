#!/bin/bash

###############################################################################
# Script Name   : logger.sh
# Description   : Log function script
# Author        : KARTHIK
# Created Date  : 05-05-2025
# Modified Date : 05-05-2025
# Version       : 1.0
# Usage         : ./logger.sh [options]
# Notes         : NA
###############################################################################

# Usage: source logger.sh in your main script
# It will auto-create a log file named after the calling script

LOG_DIR="logs"
mkdir -p "$LOG_DIR"

# Get the name of the calling script
CALLER_SCRIPT="$(basename "${BASH_SOURCE[1]}" .sh)"

    if [ ! -d "$LOG_DIR/$CALLER_SCRIPT" ]; then
        mkdir -p "$LOG_DIR/$CALLER_SCRIPT"
    else
        echo ""
    fi

LOG_FILE="$LOG_DIR/$CALLER_SCRIPT/${CALLER_SCRIPT}.log"

# Rotate log if it already exists

# Log function

MAX_LOGS=20

rotate_logs() {
    # Delete the oldest log if max limit is reached
    if [[ -f "${LOG_FILE}.${MAX_LOGS}" ]]; then
        rm -f "${LOG_FILE}.${MAX_LOGS}"
    fi

    # Rotate logs backwards
    for (( i=MAX_LOGS-1; i>=1; i-- )); do
        if [[ -f "${LOG_FILE}.${i}" ]]; then
            mv "${LOG_FILE}.${i}" "${LOG_FILE}.$((i+1))"
        fi
    done

    # Move current log to log.1
    if [[ -f "$LOG_FILE" ]]; then
        mv "$LOG_FILE" "${LOG_FILE}.1"
    fi
}

rotate_logs

log() {
    local LEVEL="$1"
    shift
    local MESSAGE="$*"
    local TIMESTAMP
    TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "$TIMESTAMP[$LEVEL] $MESSAGE" | tee -a "$LOG_FILE"
}

info()    { log "INFO" "$@"; }
warning() { log "WARNING" "$@"; }
error()   { log "ERROR" "$@"; }

