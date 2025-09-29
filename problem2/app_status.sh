#!/bin/bash
APP_URL="http://localhost:4499/"  

LOG_FILE="$HOME/app_status.log"

NOW=$(date +"%Y-%m-%d %H:%M:%S")

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

if [ "$HTTP_STATUS" -ge 200 ] && [ "$HTTP_STATUS" -lt 300 ]; then
    echo "[$NOW] Application is UP. HTTP Status: $HTTP_STATUS" | tee -a $LOG_FILE
else
    echo "[$NOW] Application is DOWN. HTTP Status: $HTTP_STATUS" | tee -a $LOG_FILE
fi
