#!/bin/bash

# Simple Bash Port Scanner
# Usage: ./port_scanner.sh <target_ip> <start_port> <end_port>

target_ip=$1
start_port=$2
end_port=$3

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <target_ip> <start_port> <end_port>"
    exit 1
fi

echo "Starting port scan on $target_ip [$start_port - $end_port]"

for (( port=$start_port; port<=$end_port; port++ ))
do
    (echo > /dev/tcp/$target_ip/$port) >/dev/null 2>&1 && echo "Port $port is open" || echo "Port $port is closed"
done

echo "Port scan completed."
