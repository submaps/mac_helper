set -e
networksetup -setv6off Wi-Fi

function internetStatus
{
 internet_status_output=$(ping -c 2 ya.ru) 
 internet_status="offline"
 if [[ $internet_status_output == *"0.0% packet loss"* ]]; then
   internet_status="online"
 fi
 echo $internet_status
}

echo current internet status `internetStatus`
sudo networksetup -setnetworkserviceenabled Wi-Fi off && sleep 2 && sudo networksetup -setnetworkserviceenabled Wi-Fi on && sudo sysctl -w net.inet.ip.ttl=64 && sleep 12 && sudo sysctl -w net.inet.ip.ttl=65
echo new internet status `internetStatus`
