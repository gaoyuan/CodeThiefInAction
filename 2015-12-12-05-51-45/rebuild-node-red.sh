#!/bin/sh
#rebuild node-red after up/down-grading node/npm versions, all under default pi user

WORK_DIR=/home/pi/node-red
LOG_FILE="$WORK_DIR/rebuild-node-red.log"

cd $WORK_DIR

    if [ -f "$LOG_FILE" ] 
    then mv "$LOG_FILE" "$LOG_FILE.$(date +%H%M%S)"
    fi

echo "entered directory $WORK_DIR ..." 2>&1 | tee "$LOG_FILE"
npm cache clear 2>&1 | tee -a "$LOG_FILE"
npm rebuild -g  2>&1 | tee -a "$LOG_FILE"
npm rebuild  2>&1 | tee -a "$LOG_FILE"
npm install 2&>1 | tee -a "$LOG_FILE"
echo "...all finished up!" 2>&1 | tee -a "$LOG_FILE"
echo "now you should run the $WORK_DIR/update-node-red.sh script!" 2>&1 | tee -a "$LOG_FILE"