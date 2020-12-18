#!/bin/tcsh
#Aleksandra Chrzanowska grupa 2

alias isIp '\
foreach i ( 1 2 3 4 ) \
    set partOfIp=`echo "$1" | cut -d "." -f "$i"` \
    if ( "$partOfIp" < 0 || "$partOfIp" > 255 ) then \
        echo "argument nie jest adresem IP" \
        exit 2 \
    endif \
end \
foreach i ( 1 2 3 4 ) \
    set partOfIp=`echo "$2" | cut -d "." -f "$i"` \
    if ( "$partOfIp" < 0 || "$partOfIp" > 255 ) then \
        echo "argument nie jest adresem IP" \
        exit 2 \
    endif \
end'

if ($# < 3) then
    echo "za mała liczba argumentów"
    exit 1
endif

isIp

set min=$1
set max=$2
foreach i ( 1 2 3 4) 
    set a=`echo "$1" | cut -d "." -f "$i"`
    set b=`echo "$2" | cut -d "." -f "$i"`
    if ( $a > $b ) then
        set min=$2
        set max=$1
        break
    endif
end

set listLen=`echo "$3" | awk -F, '{print NF}'`

set minList = ()
set maxList = ()

foreach i ( 1 2 3 4)
    set a=`echo "$min" | cut -d "." -f "$i"`
    set b=`echo "$max" | cut -d "." -f "$i"`
    set minList = ( $minList $a)
    set maxList = ( $maxList $b)
end


foreach i (`seq "${minList[1]}" "${maxList[1]}"`)
    if ( "$i" == "${minList[1]}" ) then 
        set jstart=${minList[2]} 
    else 
        set jstart=0 
    endif
    if ( "$i" == "${maxList[1]}" ) then 
        set jend=${maxList[2]} 
    else 
        set jend=255
    endif

    foreach j (`seq "$jstart" "$jend"`)
        if ( "$j" == "${minList[2]}" ) then 
            set kstart=${minList[3]} 
        else 
            set kstart=0 
        endif
        if ( "$j" == "${maxList[2]}" ) then 
            set kend=${maxList[3]}
        else 
            set kend=255
        endif

        foreach k (`seq "$kstart" "$kend"`)
            if ( "$k" == "${minList[3]}" ) then 
                set lstart=${minList[4]} 
            else 
                set lstart=1 
            endif
            if ( "$k" == "${maxList[3]}" ) then 
                set lend=${maxList[4]}
            else 
                set lend=255
            endif

            foreach l (`seq "$lstart" "$lend"`)
                set ip=("$i" "$j" "$k" "$l")
                set ipstr="${ip[1]}.${ip[2]}.${ip[3]}.${ip[4]}"
                set result=`ping -c 1 "$ipstr" | grep -c bytes`
                if ( $result > 1 ) then
                    set stat="żywy"
                else
                    set stat="martwy"
                endif
                set portStatus=()
                foreach m (`seq 1 "$listLen"`)
                    set portNumber=`echo "$3" | cut -d "," -f "$m"`
                    set resPort=`(telnet "$ipstr" "$portNumber" >/dev/null) |& grep -c telnet`
                    if ( $resPort < 1 ) then
                        set portStatus=( $portStatus $portNumber open)
                    else
                        set portStatus=( $portStatus $portNumber closed)
                    endif
                end
                printf -- "%s\t%s\t%s\n" "$ipstr" $stat "${portStatus[*]}"
            end
        end
    end
end
