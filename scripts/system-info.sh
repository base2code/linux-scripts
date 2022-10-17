#!/bin/sh
#Script to print useful system information

# Converts memory values in human readable format
function convertHuman {
    returned=$(echo $1 | awk ' \
            function human(x) { \
                if (x<1000) {return x} else {x/=1024} \
                s="MGTEPZY"; \
                while (x>=1000 && length(s)>1) \
                    {x/=1024; s=substr(s,2)} \
                return int(x+0.5) substr(s,1,1) \
        } \
        {sub(/^[0-9]+/, human($1)); print}')
    echo $returned
}

echo -e "-------------------------------System Information----------------------------"
echo -e "Hostname:\t\t"`hostname`
echo -e "Uptime:\t\t\t"`uptime | awk '{print $3,$4}' | sed 's/,//'`
echo -e "Manufacturer:\t\t"`cat /sys/class/dmi/id/chassis_vendor`
echo -e "Product Name:\t\t"`cat /sys/class/dmi/id/product_name`
echo -e "Version:\t\t"`cat /sys/class/dmi/id/product_version`
echo -e "Serial Number:\t\t"`cat /sys/class/dmi/id/product_serial`
echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi`
echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e "Kernel:\t\t\t"`uname -r`
echo -e "Architecture:\t\t"`arch`
echo -e "Processor Name:\t\t"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'`
echo -e "Active User:\t\t"`w | cut -d ' ' -f1 | grep -v USER | xargs -n1`
echo -e "System Main IP:\t\t"`hostname -I`
echo ""
echo -e "-------------------------------CPU/Memory Usage------------------------------"
MEM_USED=$(free | sed -n 2p | awk '/Mem/{printf("%i", $3)}')
MEM=$(free | sed -n 2p | awk '/Mem/{printf("%i", $2)}')
echo -e "Memory Usage:\t"$(convertHuman $MEM_USED)
echo -e "Total Memory:\t"$(convertHuman $MEM)
SWAP_USED=$(free | sed -n 3p | awk '/Swap/{printf("%i", $3)}')
SWAP=$(free | sed -n 3p | awk '/Swap/{printf("%i", $2)}')
echo -e "Swap Usage:\t"$(convertHuman $SWAP_USED)
echo -e "Total Swap\t"$(convertHuman $SWAP)
echo -e "CPU Usage:\t"`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'` 
echo ""
echo -e "----------------------------------Disk Usage---------------------------------"
df -Ph
echo ""

echo -e "--------------------------------Release State--------------------------------"
cat /etc/*-release
echo ""
