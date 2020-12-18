#!/bin/tcsh
#Aleksandra Chrzanowska grupa 2

if ($1 == '-h' || $1 == '--help') then
    printf -- "Program wyświetla tablice wybranego działania:\
            dodawanie: p\
            odejmowanie: o\
            mnożenie: m\
            dzielenie: d\
            przez podanie trzech argumentów dwóch liczb jako zakresu oraz działanie."
    exit 0
endif

if ($# < 2) then
    echo "za mała liczba argumentów"
    exit 1
endif

set firstArg=true
set dodawanie=false
set odejmowanie=false
set mnozenie=false
set dzielenie=false

foreach i ($*)
    switch ($i)
        case 'p': 
            set dodawanie=true 
            breaksw
        case 'o': 
            set odejmowanie=true
            breaksw
        case 'm':
            set mnozenie=true
            breaksw
        case 'd':
            set dzielenie=true
            breaksw
        default:
            set r=`echo $i | grep -i '^[+-]\?[0-9]*$'`
            if !(($r)) then
                echo "argument nie jest liczbą całkowitą"
                exit 2
            else
                if ($firstArg == true) then
                    set firstArg=false
                    set a=$i
                else
                    set b=$i
                endif
            endif
            breaksw
    endsw
end


set step=0

if ($a > $b) then
    set step=-1
else
    set step=1
endif

set wynik=0

printf -- "\t`seq -s '\t' $a $step $b`\n"
foreach i (`seq $a $step $b`)
    printf -- "$i\t"
    foreach j (`seq $a $step $b`)
        if ($dodawanie == true) then
            @ wynik =  $i + $j
        else if ($odejmowanie == true) then
            @ wynik = $i - $j
        else if ($mnozenie == true) then
            @ wynik = $i * $j
        else if ($dzielenie == true) then
            if ($j == 0) then
                set wynik = "-"
            else
                @ wynik = $i / $j
            endif
        else
            echo "nie znam tej opcji"
            exit 3
        endif
        printf -- "$wynik\t"
    end 
    printf -- "\n"
end 


