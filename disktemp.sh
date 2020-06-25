#!/bin/bash

# Run this script as root
if (( EUID != 0 )); then
    echo "Please run $0 as root"
    exit
fi

for dev in /dev/sd? ; do
        MODEL="$(smartctl -i "${dev}" | grep 'Device Model' | cut -d' ' -f7-)"
        TEMP="$(smartctl -A "${dev}" | grep 'Temperature_Celsius' | awk '{print $10}')"
        printf "Disk %s:\t%-25s\t%3s °C\n" "$dev" "$MODEL" "${TEMP:---}"
done