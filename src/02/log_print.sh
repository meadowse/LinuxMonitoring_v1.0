#!/bin/bash
file="$(date +"%d_%m_%y_%H_%M_%S.status")"
touch $file
echo "HOSTNAME        = $(hostname)" >> $file
echo "TIMEZONE        = $(timedatectl | grep 'Time zone' | awk '{print $3" (UTC, "$5}')" >> $file
echo "USER            = $(whoami)" >> $file
echo "OS              = $(cat /etc/issue | awk '{print $1" "$2}')" >> $file
echo "DATE            = $(date | awk '{print $2" "$3" "$4" "$5}')" >> $file
echo "UPTIME          = $(uptime -p | awk '{print $2" "$3" "$4" "$5}')" >> $file
echo "UPTIME_SEC      = $(awk '{print $1}' /proc/uptime)" >> $file
echo "IP              = $(hostname -I)" >> $file
echo "MASK            = $(netstat -rn | awk 'NR==4{print $3}')" >> $file
echo "GATEWAY         = $(ip -4 r show default | awk '{print $3}')" >> $file
echo "RAM_TOTAL       = $(grep MemTotal /proc/meminfo | awk '{printf "%.3f GB", $2/(1024*1024)}')" >> $file
echo "RAM_USED        = $(vmstat -s | grep 'used memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')" >> $file
echo "RAM_FREE        = $(vmstat -s | grep 'free memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')" >> $file
echo "SPACE_ROOT      = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')" >> $file
echo "SPACE_ROOT_USED = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $3/1024}')" >> $file
echo "SPACE_ROOT_FREE = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $4/1024}')" >> $file