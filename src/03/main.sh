#!/bin/bash
if ! [ $# -eq 4 ]
then
    echo "Incorrect number of parameters. 4 parameters expected and $# given"
else
    flag=0
    if [ $1 -eq $2 ]
    then
        flag=1
    elif [ $3 -eq $4 ]
    then
        flag=1
    fi
    if [ $flag -eq 0 ]
    then
        Reset_clr='\033[0m'
        Err=0
        case $1 in
            1 )    L_bckgrnd_clr='\033[47m' ;;   # White
            2 )    L_bckgrnd_clr='\033[41m' ;;   # Red   
            3 )    L_bckgrnd_clr='\033[42m' ;;   # Green
            4 )    L_bckgrnd_clr='\033[44m' ;;   # Blue
            5 )    L_bckgrnd_clr='\033[45m' ;;   # Purple
            6 )    L_bckgrnd_clr='\033[40m' ;;   # Black
            * )    Err=1 
            esac    
        case $2 in
            1 )    L_txt_clr='\033[0;37m' ;;   # White
            2 )    L_txt_clr='\033[0;31m' ;;   # Red   
            3 )    L_txt_clr='\033[0;32m' ;;   # Green
            4 )    L_txt_clr='\033[0;34m' ;;   # Blue
            5 )    L_txt_clr='\033[0;35m' ;;   # Purple
            6 )    L_txt_clr='\033[0;30m' ;;   # Black
            * )    Err=1 
        esac
        case $3 in
            1 )    R_bckgrnd_clr='\033[47m' ;;   # White
            2 )    R_bckgrnd_clr='\033[41m' ;;   # Red
            3 )    R_bckgrnd_clr='\033[42m' ;;   # Green
            4 )    R_bckgrnd_clr='\033[44m' ;;   # Blue
            5 )    R_bckgrnd_clr='\033[45m' ;;   # Purple
            6 )    R_bckgrnd_clr='\033[40m' ;;   # Black
            * )    Err=1 
        esac
        case $4 in
            1 )    R_txt_clr='\033[0;37m' ;;   # White
            2 )    R_txt_clr='\033[0;31m' ;;   # Red   
            3 )    R_txt_clr='\033[0;32m' ;;   # Green
            4 )    R_txt_clr='\033[0;34m' ;;   # Blue
            5 )    R_txt_clr='\033[0;35m' ;;   # Purple
            6 )    R_txt_clr='\033[0;30m' ;;   # Black
            * )    Err=1 
        esac
        if [ $Err -eq 0 ]
        then          
            echo -e $L_txt_clr$L_bckgrnd_clr"HOSTNAME        $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(hostname)$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"TIMEZONE        $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(timedatectl | grep 'Time zone' | awk '{print $3" (UTC, "$5}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"USER            $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(whoami)$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"OS              $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(cat /etc/issue | awk '{print $1" "$2}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"DATE            $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(date | awk '{print $2" "$3" "$4" "$5}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"UPTIME          $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(uptime -p | awk '{print $2" "$3" "$4" "$5}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"UPTIME_SEC      $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(awk '{print $1}' /proc/uptime)$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"IP              $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(hostname -I)$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"MASK            $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(netstat -rn | awk 'NR==4{print $3}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"GATEWAY         $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(ip -4 r show default | awk '{print $3}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"RAM_TOTAL       $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(grep MemTotal /proc/meminfo | awk '{printf "%.3f GB", $2/(1024*1024)}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"RAM_USED        $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(vmstat -s | grep 'used memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"RAM_FREE        $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(vmstat -s | grep 'free memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"SPACE_ROOT      $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"SPACE_ROOT_USED $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(df /root/ | awk '/\/$/ {printf "%.2f MB", $3/1024}')$Reset_clr"
            echo -e $L_txt_clr$L_bckgrnd_clr"SPACE_ROOT_FREE $Reset_clr=$R_txt_clr$R_bckgrnd_clr $(df /root/ | awk '/\/$/ {printf "%.2f MB", $4/1024}')$Reset_clr"
        else
            echo "Incorrect parameter: parameters must be a numbers in diapason 1-6"              
        fi
    else
        echo "Incorrect parameter: Parameters 1 and 2 must not be equal. Also parameters 3 and 4 must not be equal. Enter another parameter values"
    fi
fi