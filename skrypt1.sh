#!/bin/bash
#Aleksandra Chrzanowska grupa 2

beQuiet=false
sthWrong=false

pomoc="Wywołany program bez żadnych argumentów podaje login name oraz imię i nazwisko wywołującego."

while [ $# -ne 0 ]; do
    for i in $@; do
        case "$i" in
        "-h" | "--help")
            echo $pomoc
            exit 0
            ;;
        "-q" | "--quiet")
            beQuiet=true
            shift
            ;;
        -*)
            sthWrong=true
            shift
            ;;
        *)
            shift
            ;;
        esac
    done
done

if [ "$beQuiet" = true ]; then
    exit 0
elif [ "$sthWrong" = true ]; then
    echo "Nie znam tej opcji"
    echo $pomoc
    exit 1
else
    echo $USER
    echo $(getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1)
    exit 0
fi
