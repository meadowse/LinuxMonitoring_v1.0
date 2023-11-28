#!/bin/bash
echo "HOSTNAME        = $(hostname)"
echo "TIMEZONE        = $(timedatectl | grep 'Time zone' | awk '{print $3" (UTC, "$5}')"
echo "USER            = $(whoami)"
echo "OS              = $(cat /etc/issue | awk '{print $1" "$2}')"
echo "DATE            = $(date | awk '{print $2" "$3" "$4" "$5}')"
echo "UPTIME          = $(uptime -p | awk '{print $2" "$3" "$4" "$5}')"
echo "UPTIME_SEC      = $(awk '{print $1}' /proc/uptime)"
echo "IP              = $(hostname -I)"
echo "MASK            = $(netstat -rn | awk 'NR==4{print $3}')"
echo "GATEWAY         = $(ip -4 r show default | awk '{print $3}')"
echo "RAM_TOTAL       = $(grep MemTotal /proc/meminfo | awk '{printf "%.3f GB", $2/(1024*1024)}')"
echo "RAM_USED        = $(vmstat -s | grep 'used memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')"
echo "RAM_FREE        = $(vmstat -s | grep 'free memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')"
echo "SPACE_ROOT      = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')"
echo "SPACE_ROOT_USED = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $3/1024}')"
echo "SPACE_ROOT_FREE = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $4/1024}')"
echo -n "Do you want to save log in a file? (Y/N):"
read answer
case $answer in
    [Yy]* ) chmod 777 log_print.sh; sh log_print.sh; break;;
    * ) exit;;
esac