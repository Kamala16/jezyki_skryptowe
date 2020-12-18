#!/bin/tcsh
#Aleksandra Chrzanowska grupa 2

set wynik=0
printf -- "\t`seq -s '\t' 1 9`\n"
foreach i (`seq 1 9`)
    printf -- "$i\t"
    foreach j (`seq 1 9`)
        @ wynik =  $i * $j
        printf -- "$wynik\t"
    end
    printf -- "\n"
end

