#!/bin/bash

OPTIND=1

mac=""
iname=""
dhcp=""

function show_help {
  echo "Usage : $0 -i <bond name> -m <bond mac> [-d] <iface1> <iface2> [<iface3> <iface4>]"
  echo "           -i <bond name>                          name for the interface"
  echo "           -m <bond mac>                           mac address to set for interface"
  echo "           -d                                      do dhcp on interface"
  echo "           <iface1> <iface2> [<iface3> <iface4>]   interfaces to bound"
  exit 0
}

while getopts "h?di:m:" opt; do
    case "$opt" in
    h|\?)
        show_help
        ;;
    d)  
        dhcp="yes"
        ;;
    m)  mac=$OPTARG
        ;;
    i)  iname=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift # Handle -- for option end

[ "$mac" = "" ]                  && show_help
[ "$iname" = "" ]                && show_help
[ "$#" -ne 2 ] && [ "$#" -ne 4 ] && show_help

#modprobe bonding miimon=100 mode=4 lacp_rate=slow  # mode 4 = LACP (802.3ad)

[ "$dhcp" = "yes" ] && ip route flush table main
ip link add dev $iname type bond

echo '4'        > /sys/class/net/$iname/bonding/mode
echo '100'      > /sys/class/net/$iname/bonding/miimon
echo 'slow'     > /sys/class/net/$iname/bonding/lacp_rate
echo 'layer3+4' > /sys/class/net/$iname/bonding/xmit_hash_policy

for iface in "$@"
do
    ip address flush dev $iface
    ip link set dev $iface down
    ip link set dev $iface master $iname
done

ip link set $iname address $mac
ip link set dev $iname up


[ "$dhcp" = "yes" ] && dhclient -v $iname
