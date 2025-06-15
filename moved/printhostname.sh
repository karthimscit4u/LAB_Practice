#! /bin/bash
#Description 	: Print the hostname
#create on	    : 13th April 2025

#Revison History
#
source logfile.sh
create_log_directory "$0"  # Passes the current script name (main.sh)

host=$(hostname)
echo $host

log_message "INFO" "$host"