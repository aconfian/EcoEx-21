#!/bin/bash

server="10.0.0.1"
count=16

for ((i = 0 ; i < $count ; i++))
do
    iperf3 -c $server -p $((5200+i)) -P 48 -t 0 >/dev/null 2>&1 &
done >/dev/null 2>&1

bwm-ng -u bits -d 1 -I public,private
kill -15 `pidof iperf3` >/dev/null 2>&1
