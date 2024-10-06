#!/bin/bash
BASEDIR=$(cd "$(dirname "$0")" && pwd)
CUSTOM_DATE_FORMAT="%Y%m%d%H%M%S"


if [ $# -eq 1 ] && [ ! -d "$1" ]; then
    echo "$1 directory does not exist."
    exit 1;
elif [ $# -gt 1 ]; then
    echo "Please specify only one target folder."
    exit 1;
fi

while true; do
if [ $# -eq 0 ]; then
    LOG_FILE="${BASEDIR}/log_$(date +${CUSTOM_DATE_FORMAT}).log"
    echo "${LOG_FILE}"
    echo "DummyLog_${LOG_FILE}" > "${LOG_FILE}"
else
    LOG_FILE="${1}/log_$(date +${CUSTOM_DATE_FORMAT}).log"
    if [ ! -f $LOG_FILE ]; then
        echo "${LOG_FILE}"
        echo "DummyLog_${LOG_FILE}" > "${LOG_FILE}"
    fi
fi
done


