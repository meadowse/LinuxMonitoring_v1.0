#!/bin/bash
if [ $# -ge 1 ]
then
    echo "Error: No parameters expected and $# parameter(s) given"
else
    co=config.cnf
    if [ -e $co ]
    then
        source config.cnf
        export L_bckgrnd_clr=$column1_background
        export L_txt_clr=$column1_font_color
        export R_bckgrnd_clr=$column2_background
        export R_txt_clr=$column2_font_color
        if [[ $L_bckgrnd_clr = "" ]]; then
            L_bckgrnd_clr=6 ; column1_background="default"
        fi
        if [[ $L_txt_clr = "" ]]; then
            L_txt_clr=1 ; column1_font_color="default"
        fi
        if [[ $R_bckgrnd_clr = "" ]]; then
            R_bckgrnd_clr=2 ; column2_background="default"
        fi
        if [[ $R_txt_clr = "" ]]; then
            R_txt_clr=4 ; column2_font_color="default"
        fi
        flag=1
        if [ $L_bckgrnd_clr -eq $L_txt_clr ]
        then
            flag=0
        elif [ $R_bckgrnd_clr -eq $R_txt_clr ]
        then
            flag=0
        fi
        if [ $flag -eq 1 ]
        then
            Reset_clr='\033[0m'
            Err=1
            case $L_bckgrnd_clr in
                1 )    L_bckgrnd_clr='\033[47m' ; L_bckgrnd_txt='white' ;;   # white
                2 )    L_bckgrnd_clr='\033[41m' ; L_bckgrnd_txt='red' ;;   # red   
                3 )    L_bckgrnd_clr='\033[42m' ; L_bckgrnd_txt='green' ;;   # green
                4 )    L_bckgrnd_clr='\033[44m' ; L_bckgrnd_txt='blue' ;;   # blue
                5 )    L_bckgrnd_clr='\033[45m' ; L_bckgrnd_txt='purple' ;;   # purple
                6 )    L_bckgrnd_clr='\033[40m' ; L_bckgrnd_txt='black' ;;   # black
                * )    Err=0;;
            esac    
            case $L_txt_clr in
                1 )    L_txt_clr='\033[0;37m' ; L_txt_txt='white' ;;   # white
                2 )    L_txt_clr='\033[0;31m' ; L_txt_txt='red' ;;   # red   
                3 )    L_txt_clr='\033[0;32m' ; L_txt_txt='green' ;;   # green
                4 )    L_txt_clr='\033[0;34m' ; L_txt_txt='blue' ;;   # blue
                5 )    L_txt_clr='\033[0;35m' ; L_txt_txt='purple' ;;   # purple
                6 )    L_txt_clr='\033[0;30m' ; L_txt_txt='black' ;;   # black
                * )    Err=0;;
            esac
            case $R_bckgrnd_clr in
                1 )    R_bckgrnd_clr='\033[47m' ; R_bckgrnd_txt='white' ;;   # white
                2 )    R_bckgrnd_clr='\033[41m' ; R_bckgrnd_txt='red' ;;   # red   
                3 )    R_bckgrnd_clr='\033[42m' ; R_bckgrnd_txt='green' ;;   # green
                4 )    R_bckgrnd_clr='\033[44m' ; R_bckgrnd_txt='blue' ;;   # blue
                5 )    R_bckgrnd_clr='\033[45m' ; R_bckgrnd_txt='purple' ;;   # purple
                6 )    R_bckgrnd_clr='\033[40m' ; R_bckgrnd_txt='black' ;;   # black
                * )    Err=0;;
            esac
            case $R_txt_clr in
                1 )    R_txt_clr='\033[0;37m' ; R_txt_txt='white' ;;   # white
                2 )    R_txt_clr='\033[0;31m' ; R_txt_txt='red'  ;;   # red   
                3 )    R_txt_clr='\033[0;32m' ; R_txt_txt='green'  ;;   # green
                4 )    R_txt_clr='\033[0;34m' ; R_txt_txt='blue'  ;;   # blue
                5 )    R_txt_clr='\033[0;35m' ; R_txt_txt='purple'  ;;   # purple
                6 )    R_txt_clr='\033[0;30m' ; R_txt_txt='black'  ;;   # black
                * )    Err=0;;
            esac
            if [ $Err -eq 1 ]
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
                echo
                echo "Column 1 background = $column1_background ($L_bckgrnd_txt)"
                echo "Column 1 font color = $column1_font_color ($L_txt_txt)"
                echo "Column 2 background = $column2_background ($R_bckgrnd_txt)"
                echo "Column 2 font color = $column2_font_color ($R_txt_txt)"
            else
                echo "Incorrect parameter value in config.cnf file: parameters must be a numbers in diapason 1-6"
            fi
        else
            echo "Incorrect parameter value in config.cnf file: Parameters column1_background and column1_font_color must not be equal. Also parameters column2_background and column2_font_color must not be equal. Enter another parameter values"
        fi
    else
        echo "The $co file does not exist"
    fi    
fi
