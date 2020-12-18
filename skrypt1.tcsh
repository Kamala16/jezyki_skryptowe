#!/bin/tcsh
#Aleksandra Chrzanowska grupa 2

set beQuiet=false
set sthWrong=false

set pomoc="Wywołany program bez żadnych argumentów podaje login name oraz imię i nazwisko wywołującego"

while ($# != 0)
    foreach i ($*)
        switch ($i)
            case '-h':
            case '--help':
                echo $pomoc
                exit 0
            case '-q':
            case '--quiet':
                set beQuiet=true
                shift
                breaksw
            case -*:
                set sthWrong=true
                shift
                breaksw
            default:
                shift
                breaksw
        endsw
    end 
end

if ($beQuiet == true) then
    exit 0
else if ($sthWrong == true) then
    echo "Nie znam tej opcji"
    echo $pomoc
    exit 1
else
    echo $USER
    set userFullInfo=`getent passwd $USER`
    set userInfo=`echo $userFullInfo | cut -d ':' -f 5`
    set userName=`echo $userInfo | cut -d ',' -f 1`
    echo $userName
    exit 0
endif
