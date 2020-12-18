#!/bin/tcsh
#Aleksandra Chrzanowska grupa 2

set a=0
set b=0

if ($# < 2) then
    echo "za mała liczba argumentów"
    exit 1
endif
set r1=`echo $1 | grep -i '^[+-]\?[0-9]*$'`
set r2=`echo $2 | grep -i '^[+-]\?[0-9]*$'`
   
if !(($r1) || ($r2)) then
    echo "argument nie jest liczbą całkowitą"
    exit 2
endif

if ($1 > $2) then
    set a=$2
    set b=$1
else
    set a=$1
    set b=$2
endif

set wynik=0

printf -- "\t`seq -s '\t' $a $b`\n"
foreach i (`seq $a $b`)
    printf -- "$i\t"
    foreach j (`seq $a $b`)
        @ wynik =  $i * $j
        printf -- "$wynik\t"
    end
    printf -- "\n"
end

