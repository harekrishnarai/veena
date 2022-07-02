declare -i TTL=0

for x in $(cat IPs.txt)
do
        TTL=$(ping -c 1 -w 1 $x | grep "ttl=" | awk -F " " '{print $6}' | sed -e 's/ttl=//g')
        if [ "$TTL" -eq 0 ] # Checking if the IP is down
        then
                : # Do Nothing

        elif [ "$TTL" -le 64 ]
        then
                echo $x "= Linux, TTL=" $TTL #tells that the system is probably Linux


        elif [ "$TTL" -ge 65 -a "$TTL" -le 128 ]
        then
                echo $x "= Windows, TTL=" $TTL #tells that the system is probably Windows

        else
                echo $x "= Solaris / Cisco, TTL=" $TTL #tells that the system is probably Solaris/Cisco OS
        fi
done
