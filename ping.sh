#!/bin/bash
# Script for checking if I have working internet
# Written by chatgpt lmao


LOG_FILE="log.txt"
PING_HOST="8.8.8.8"  # Google's DNS
LAST_STATE=""

# Log the event with a timestamp
log_event() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$TIMESTAMP - $1" >> $LOG_FILE
}

# Check internet connection by pinging
ping_check() {
    ping -c 1 $PING_HOST > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "online"
    else
        echo "offline"
    fi
}

# Initialize log if it doesn't exist
if [ ! -f $LOG_FILE ]; then
    touch $LOG_FILE
    log_event "Logging started"
fi

while true; do
    CURRENT_STATE=$(ping_check)
    if [ "$CURRENT_STATE" != "$LAST_STATE" ]; then
        if [ "$CURRENT_STATE" == "online" ]; then
            log_event "Internet connection restored"
        else
            log_event "Internet connection lost"
        fi
        LAST_STATE=$CURRENT_STATE
    fi
    sleep 60  # Ping every 60 seconds
done
