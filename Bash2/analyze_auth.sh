#!/bin/bash

ip="$1"

if [[ -z "$ip" ]];then
	echo "No Argument Provided" >&2
	exit 2
fi

authfile="./linux_day2/logs/auth.log"

if [[ ! -f "$authfile" ]];then
	echo "auth.log not found" >&2
	exit 1
fi

ssherror=$(grep "$ip" "$authfile" | awk '/Failed/ {print}')

failcount=$(grep "$ip" "$authfile" | awk '/Failed/ {print}' | wc -l )

targetUser=$(grep "$ip" "$authfile" | awk '/Failed/ {print}' | awk '{print $9}' | sort -u)

firsttimestamp=$(grep "$ip" "$authfile" | awk '/Failed/ {print}' | awk '{print $3}' | sort -n | head -n 1 )

lasttimestamp=$(grep "$ip" "$authfile" | awk '/Failed/ {print}' | awk '{print $3}' | sort -n | tail -n 1 )

echo "IP: $ip"
echo "Failed Attempts: $failcount"
echo "Users Targeted: $targetUser"
echo "First Attempt: $firsttimestamp"
echo "Last Attempt: $lasttimestamp"
