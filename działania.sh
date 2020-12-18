#!/bin/bash
#Aleksandra Chrzanowska grupa 2

if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]
then
    echo "Program wyświetla tablice wybranego działania:
            dodawanie: p
            odejmowanie: o
            mnożenie: m
            dzielenie: d
            przez podanie trzech argumentów dwóch liczb jako zakresu oraz działanie."
    exit 0
fi

if [ $# -lt 3 ]
then
    echo "za mała liczba argumentów"
    exit 1
fi

re='^[+-]?[0-9]+$'
firstArg=true
dodawanie=false
odejmowanie=false
mnozenie=false
dzielenie=false

for i in $@
do
    case "$i" in
        "p") dodawanie=true ;;
        "o") odejmowanie=true ;;
        "m") mnozenie=true ;;
        "d") dzielenie=true ;;
        *)
            if ! [[ $i =~ $re ]]
            then
               echo "argument nie jest liczbą całkowitą"
               exit 2
            else
                if [[ $firstArg == true ]]
                then
                    firstArg=false
                    a=$i
                else
                    b=$i
                fi
            fi
            ;;
    esac
done

if [[ $a -gt $b ]]
then
    step=-1
else
    step=1   
fi

printf -- "\t$(seq -s '\t' $a $step $b)\n"
for i in $(seq $a $step $b)
do
    printf -- "$i\t"
    for j in $(seq $a $step $b) 
    do 
        if [[ $dodawanie == true ]]
        then
             printf -- "$(( i + j ))\\t"
        elif [[ $odejmowanie == true ]]
        then
             printf -- "$(( i - j ))\\t"
        elif [[ $mnozenie == true ]]
        then
             printf -- "$(( i * j ))\\t"
        elif [[ $dzielenie == true ]]
        then
             if [[ $j -eq 0 ]]
             then
                printf -- "\\t"
             else
                 printf -- "$(( i / j ))\\t"
             fi
        else
             echo "nie znam tej opcji"
             exit 3 
        fi
    done 
    printf "\n"
done

