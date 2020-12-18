#!/bin/tcsh
#Aleksandra Chrzanowska grupa 2

set rootdir=`dirname $0`
set sciezka=`cd $rootdir && pwd`

set port=16039
set iloscZliczen=0
set ip=localhost

if ($# < 1) then
    echo "za mała liczba argumentów"
    exit 1
endif

while ($# != 0)
    switch($1)
        case '-p':
            set port="$2"
            shift
            shift
            breaksw
        case '-s':
            set rodzajProgramu=serwer
            shift
            breaksw
        case '-c':
            set rodzajProgramu=klient
            shift
            breaksw
        case '-i':
            set ip=$2
            shift
            shift
            breaksw
        default:
            shift
            breaksw
    endsw
end

switch($rodzajProgramu)
    case 'serwer':
        onintr int
        set file="$sciezka/zliczenia-$port.txt"        
        if (-f "$file") then 
            set iloscZliczen=`cat "$file"` 
        else 
            set iloscZliczen=0
        endif
        echo "wczytałem $iloscZliczen" 
            while (1 == 1) 
                set wywolanie = $iloscZliczen
                @ wywolanie = $iloscZliczen + 1
                set res=`echo $wywolanie | nc -l localhost -p "$port" -c -s "$ip"` 
                echo $res 
                if ($res == 1) then 
                    echo "nie można uruchomic serwera dwa razy na tym samym porcie" 
                    exit 2 
                else 
                    @ iloscZliczen = "$iloscZliczen" + 1 
                endif 

            end
            int: 
            set file="$sciezka/zliczenia-$port.txt" 
            echo $file 
            echo "Zapisuje do pliku $iloscZliczen" 
            echo "$iloscZliczen" > "$file" 
            exit 0
        breaksw
    case 'klient':
        nc -w 2 "$ip" "$port"
        breaksw
    default:
        breaksw
endsw

