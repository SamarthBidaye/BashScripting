#!/bin/bash

filetoFind="./linux_day3/process_lab/process.txt"
argument="$1"

if [[ "$#" -ne 1 ]];then
	echo "Usage: $0 <username>"
	exit 2
fi

if [[ ! -f "$filetoFind" ]];then
	echo "Error: process.txt not found."
	exit 1
fi

userprocess=$(ps -ef | grep -w "samarth")

NumberofProcess= echo "$userprocess" | wc -l

highMempid=$(ps aux | grep -w "samarth" | sort -k4 -nr | awk '{print $2}' | head -n 1 )


memUsage=$(ps aux | grep -w "samarth" | sort -k4 -nr | awk '{print $4}' | head -n 1 )

cpuUsage=$(ps aux | grep -w "samarth" | sort -k4 -nr | awk '{print $3}' | head -n 1 )

echo "User: $argument"
echo "Process Count: $NumberofProcess"
echo "Higest Mem : $highMempid"
echo "MemUsage : $memUsage"
echo "CPU Usage: $cpuUsage"
