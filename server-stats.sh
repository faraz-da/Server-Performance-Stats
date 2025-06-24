#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}')
echo "---------------------"
echo "Cpu usage:$cpu_usage"
echo "---------------------"

read total used <<< $(free | awk 'NR==2{print $2, $3}')
percent=$(awk "BEGIN {printf \"%.2f\", $used/$total*100}")


echo "Memory Usage Info (/):"
echo "---------------------"
echo "Total memory: $((total/1024)) MB"
echo "Used memory : $((used/1024)) MB"
echo "Used percent: $percent %"

read total used free percent <<< $(df / | awk 'NR==2 {print $2, $3, $4, $5}')

echo "---------------------"
echo "Disk Usage Info (/):"
echo "---------------------"
echo "Total: $((total)) KB"
echo "Used : $((used)) KB"
echo "Free : $((free)) KB"
echo "Used Percent: $percent"
echo "---------------------"


echo "Top 5 CPU-consuming processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""
echo "Top 5 Memory-consuming processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
