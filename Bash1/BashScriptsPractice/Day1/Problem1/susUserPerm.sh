#!/bin/bash

arg1="$1"

if [[ -z "$arg1" ]];then
	echo "Argument Empty" >&2
	exit 1
fi

if [[ ! -d "$arg1" && ! -f "$arg" ]];then
	echo "No File or Directory Exists with the matching path"
	exit 1
fi

allfile+=("$arg1"/*)

varSuid=()
grpwriteable=()
allwriteable=()


for val in "${allfile[@]}"
do
	prem=$(stat -c '%A' "$val")
	grpPermission="${prem:4:3}"
	otherPermission="${prem:7:9}"
	if [[ -u "$val" ]];then
		endfile=$( echo "$val" | awk -F '/' '{print $NF}')
		varSuid+="$endfile"
	fi

	if [[ "$grpPermission" == *w* ]];then
		ef=$(echo "$val" | awk -F '/' '{print $NF}')
		grpwriteable+="$ef"	
	fi

	if [[ "$otherPermission" == *w* ]];then
		ef=$(echo "$val" | awk -F '/' '{print $NF}')
	       allwriteable+="$ef"
	fi	       
done

for suid in "${varSuid[@]}"
do
	echo "$suid SUID"
done

for gw in "${grpwriteable[@]}"
do
	echo "$gw GROUP-WRITEABLE"
done

for wr in "${allwriteable[@]}"
do
	echo "$wr WORLD-WRITEABLE"
done
