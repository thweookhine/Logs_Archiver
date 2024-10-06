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

# Check if LOG_DIR exists
if [ ! -d  "${LOG_DIR}" ]; then
    echo "Directory $LOG_DIR does not exist."
    exit ${ERR}
fi

for log_file in "$LOG_DIR"/*.log; do
    if [ -f "$log_file" ]; then
        filename=$(basename "${log_file}")

        #extract ymd value

        if [[ $filename =~ ([0-9]{8}) ]]; then
            date_ymd="${BASH_REMATCH[1]}"
            # Append the log file path to the corresponding YMD key
            if [[ -n "${log_files_map[$date_ymd]}" ]]; then
                log_files_map[$date_ymd]+=" $log_file"
            else
                log_files_map[$date_ymd]="$log_file"
        fi
        else
            echo "No date found in the filename. File => <${filename}>"
        fi
    fi
done

# Create Root Archives Directory if not exist
#mkdir -p $TARGET_DIR

for ymd in "${!log_files_map[@]}"; do
    if [ -f ${LOG_DIR}/${ymd}.tar.gz ]; then
        tar -cvf "${LOG_DIR}/${ymd}_${currentTimestamp}.tar.gz" ${log_files_map[$ymd]} > /dev/null 2>&1
        echo "Successfully Archived to ${LOG_DIR}/${ymd}_${currentTimestamp}"
        rm ${log_files_map[$ymd]}
    else
        tar -cvf ${LOG_DIR}/${ymd}.tar.gz ${log_files_map[$ymd]} > /dev/null 2>&1
        echo "Successfully Archived to $LOG_DIR/$ymd"
        rm ${log_files_map[$ymd]}
    fi
    
done
