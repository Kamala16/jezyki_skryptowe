#!/bin/bash
#Aleksandra Chrzanowska grupa 2

if [ $# -lt 2 ]
then
    echo "za mała liczba argumentów"
    exit 1
fi

re='^[+-]?[0-9]+$'
if ! [[ $1 =~ $re ]] || ! [[ $2 =~ $re ]]
then
    echo "argument nie jest liczbą całkowitą"
    exit 2
fi

if [ $1 -gt $2 ]
then
    a=$2
    b=$1
else
    a=$1
    b=$2    
fi

printf -- "\t$(seq -s '\t' $a $b)\n"
for i in $(seq $a $b)
do
    printf -- "$i\t"
    for j in $(seq $a $b) 
    do 
         printf -- "$(( i * j ))\\t" 
    done 
    printf "\n"
done

