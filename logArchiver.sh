#!/bin/bash

SHELL_NAME=$(basename "$0")
ERR="1"
SAMPLE_CMD="bash ${SHELL_NAME} LOG_DIR"
filename=""
declare -A log_files_map
currentTimestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Check Arg Count
if [ $# -eq 0 ]; then
    echo "Please Write LOG_DIRECTORY Argument"
    echo "Sample Command: ${SAMPLE_CMD}"
    exit ${ERR}
elif [ $# -ge 2 ]; then
    echo "Arg count is more than one."
    echo "Sample Command: ${SAMPLE_CMD}"
    exit ${ERR}
fi
LOG_DIR="$1"
TARGET_DIR=${LOG_DIR}/../LOGS_ZIP

# Check if LOG_DIR exists
if [ ! -d  "${LOG_DIR}" ]; then
    echo "Directory $LOG_DIR does not exist."
    exit ${ERR}
else    
    tar -czf "${LOG_DIR}/logs_archive_$currentTimestamp.tar.gz" -C "$LOG_DIR" . > /dev/null 2>&1
    echo "Successfully Archived as ${LOG_DIR}/logs_archive_$currentTimestamp.tar.gz"
    rm -rf "$LOG_DIR"/*.log
fi
