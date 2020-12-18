#!/bin/bash
#Aleksandra Chrzanowska grupa 2

isIp() {

    for ip in "$@"; do
        for i in $(seq 1 4); do
            partOfIp=$(echo "$ip" | cut -d '.' -f "$i")
            if [[ $partOfIp -lt 0 || $partOfIp -gt 255 ]]; then
                echo "argument nie jest adresem IP"
                exit 2
            fi
        done
    done
}

if [ $# -lt 3 ]; then
    echo "za mała liczba argumentów"
    exit 1
fi

isIp "$1" "$2"

min=$1
max=$2
for i in $(seq 1 4); do
    a=$(echo "$1" | cut -d '.' -f "$i")
    b=$(echo "$2" | cut -d '.' -f "$i")
    if [[ $a -gt $b ]]; then
        min=$2
        max=$1
        break
    fi
done

listLen=$(echo "$3" | awk -F, '{print NF}')

IFS='.' read -r -a from <<<"$min"
IFS='.' read -r -a to <<<"$max"

ipstring() {
    local arr=("$@")
    echo "${arr[0]}.${arr[1]}.${arr[2]}.${arr[3]}"
}


for i in $(seq "${from[0]}" "${to[0]}"); do
    if [ "$i" -eq "${from[0]}" ]; then jstart=${from[1]}; else jstart=0; fi
    if [ "$i" -eq "${to[0]}" ];   then jend=${to[1]};     else jend=255; fi

    for j in $(seq "$jstart" "$jend"); do
        if [ "$j" -eq "${from[1]}" ]; then kstart=${from[2]}; else kstart=0; fi
        if [ "$j" -eq "${to[1]}" ];   then kend=${to[2]};     else kend=255; fi

        for k in $(seq "$kstart" "$kend"); do
            if [ "$k" -eq "${from[2]}" ]; then lstart=${from[3]}; else lstart=1; fi
            if [ "$k" -eq "${to[2]}" ];   then lend=${to[3]};     else lend=255; fi

            for l in $(seq "$lstart" "$lend"); do
                ip=("$i" "$j" "$k" "$l")
                ipstr=$(ipstring "${ip[@]}")
                result=$(ping -c 1 "$ipstr" | grep -c bytes)
                if [[ $result -gt 1 ]]; then
                    status="żywy"
                else
                    status="martwy"
                fi
                portsStatus=()
                for m in $(seq 1 "$listLen"); do
                    portNumber=$(echo "$3" | cut -d ',' -f "$m")
                    exec 2>/dev/null 3<>/dev/tcp/"$ipstr"/"$portNumber"
                    res="$?"
                    if [[ res -eq 0 ]]; then
                        echo -e "GET / HTTP/1.1\r\n\r\n" 2&>/dev/null >&3
                        serviceName=$(cat <&3 | grep "Server" | cut -d ':' -f 2)
                        serviceName=$(echo "$serviceName" | sed 's/\r//g')
                        if [[ -z $serviceName ]]; then
                            portsStatus=("${portsStatus[@]}" "$portNumber: unknown,")
                        else
                            portsStatus=("${portsStatus[@]}" "$portNumber: $serviceName,")
                        fi
                    else
                        portsStatus=("${portsStatus[@]}" "$portNumber: closed,")
                    fi                  
                done
                printf -- "%s\t%s\t%s\n" "$ipstr" $status "${portsStatus[*]}"
            done
        done
    done
done


