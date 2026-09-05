#!/bin/bash

# Copyright barraquad (c) 2026
# Use at your own risk!
# Licensed under BSD license. Do not take credit for this!

millis=$(date +%s)

echo -n "Enter starting port: "
read start

echo -n "Enter number of iperf server instances(starting from port $start): "
read ports

err_rate=0

for ((i=0; i<=ports; i++)); do
	port=$((5000 + i))
	iperf -s -p $port >> "log_$millis.txt" 2>> "error_$millis.log" &
	
	exit_code=$(echo $?)
	if [ $exit_code != 0 ]; then
		ports=$((ports + 1))
		err_rate=$((err_rate + 1))
	fi	
done

if [ $err_rate -gt 0 ]
then
	echo "$err_rate errors occured at starting servers. Check error_$millis.log for details."
fi
