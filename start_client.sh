#!/bin/bash

# Copyright barraquad (c) 2026
# Use at your own risk!
# Licensed under BSD license. Do not take credit for this!

millis=$(date +%s)

echo -n "Enter a valid host: "
read server_addr

echo -n "Enter starting port: "
read start

echo -n "Enter number of iperf client instances(starting from port $start): "
read ports

echo -n "Parallel streams to each port?"
read stream

echo -n "TCP? (y/n) "
read tcp

echo -n "UDP? (y/n) "
read udp

for ((i=0; i<=ports; i++)); do
	port=$(($start + i))
	
	if [[ $tcp =~ .*y.* ]]; then
		iperf -c $server_addr -p $port -P $stream 2>> "error_$millis.log" &
	fi
	if [[ $udp =~ .*y.* ]]; then
		iperf -c $server_addr -p $port -P $stream -u 2>> "error_$millis.log" &
	fi
done >> "log_$millis.txt" 
