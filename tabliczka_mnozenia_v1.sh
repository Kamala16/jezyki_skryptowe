#!/bin/bash
#Aleksandra Chrzanowska grupa 2

for i in $(seq 1 9)
do
    echo -e "\ni "
    for j in $(seq -s ' ' 1 9); do 
         printf " $((i*j))" 
    done 
done
