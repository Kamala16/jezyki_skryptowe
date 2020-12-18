#!/bin/bash
#Aleksandra Chrzanowska grupa 2

path="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

port=16039
iloscZliczen=0
ip=localhost

zapiszDoPliku() {
    file="$path/zliczenia-$port.txt"
    echo "Zapisuje do pliku $iloscZliczen"
    echo "$iloscZliczen" > "$file"
    exit 0
}

wczytajZliczenia() {
    file="$path/zliczenia-$port.txt"
    if [[ -f "$file" ]]; then
        cat "$file"
    else
        echo "0"
    fi
}

serverOn() {
    trap zapiszDoPliku SIGINT
    iloscZliczen=$(wczytajZliczenia)
    echo "wczytałem $iloscZliczen"
    while true; do
        res=$(echo -e "$(( iloscZliczen+1 ))" | nc -l localhost -p "$port" -c -s "$ip" 2>/dev/null )
        if [[ "$res" == 1 ]]; then
            echo "nie można uruchomic serwera dwa razy na tym samym porcie"
            exit 2
        else 
            iloscZliczen=$(( iloscZliczen+1 ))
        fi
    done
}

clientOn() {
    nc -w 2 "$ip" "$port"
}

if [[ $# -lt 1 ]]; then
    echo "za mała liczba argumentów"
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
    "-p")
        port=$2
        shift
        shift
        ;;
    "-s")
        rodzajProgramu=serwer
        shift
        ;;
    "-c")
        rodzajProgramu=klient
        shift
        ;;
    "-i")
        ip=$2
        shift
        shift
        ;;
    *)
        shift
        ;;
    esac
done

case "$rodzajProgramu" in
"serwer")
    serverOn
    ;;
"klient")
    clientOn
    ;;
*) ;;

esac
