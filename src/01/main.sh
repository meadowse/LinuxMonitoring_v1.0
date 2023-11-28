#!/bin/bash
if ! [ $# -eq 1 ]
then
    echo "Incorrect number of parameters. 1 parameter expected and $# given"
else
    re='^[+-]?[0-9]+([.][0-9]+)?$'
    if ! [[ $1 =~ $re ]]
    then
        echo $1
    else
        echo "Incorrect parameter type: number. Enter non-number parameter"
    fi
fi
