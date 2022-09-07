#!/bin/bash

# Path to rocketlogger data socket
RL_SOCKET=/tmp/rlstream.socket
# Path to teros data socket
TEROS_SOCKET=/tmp/terosstream.socket
# Path to USB port for teroslogger
DEV=/dev/ttyACM0
# Number of samples per upload
NUM_SAMPLES=20
# Path to log temperary data to
DATA_PATH=/tmp/rl_data
# Transmission method (lora/ethernet)
METHOD=ethernet

# Create data folder if dne
if [[ ! -d $DATA_PATH ]]; then
	mkdir -p $DATA_PATH
fi

lora $TEROS_SOCKET $RL_SOCKET $NUM_SAMPLES $METHOD&
sleep 2s
teroslogger -q -s $TEROS_SOCKET /dev/ttyACM0 &
sleep 2s

while true; do
	TIMESTAMP=`date +"%Y-%m-%d_%T"`
	RL_FILENAME="${DATA_PATH}/${TIMESTAMP}_rl.csv"
	rocketlogger sample $NUM_SAMPLES -r 1 -format csv -f $RL_FILENAME -ch 0,1,2,3,4,5 -d 0 -w 0
	csvstream $RL_SOCKET $RL_FILENAME
done
