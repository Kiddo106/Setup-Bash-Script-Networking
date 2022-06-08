#!/bin/bash
#Purpose: Script that will output general network information.
#Purpose: The networking information includes service status, network settings, and ping results.
#Date: May 21, 2022
#Coder: Stephano G.

#Networking services status section
#Turns off NetworkManager
sudo systemctl disable NetworkManager.service > /dev/null 2>&1
sudo systemctl stop NetworkManager.service> /dev/null 2>&1

#Enables networking services
sudo systemctl start network.service> /dev/null 2>&1
sudo systemctl enable network.service> /dev/null 2>&1

#Turns off firewalld
sudo systemctl stop firewalld> /dev/null 2>&1
systemctl disable firewalld> /dev/null 2>&1

#Turns off iptables
sudo systemctl stop iptables> /dev/null 2>&1
sudo systemctl disable iptables> /dev/null 2>&1

echo "Networking settings; NetworkManager, network service, Firewalld, SELinux have been adjusted"
echo ""
#Displaying network settings section
#RED network information
echo -n "RED interface ip: "
ip -4 addr show ens34 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
echo "Linked interface with RED the network: ens34"
echo ""
#BLUE network information
echo -n "BLUE interface ip: "
ip -4 addr show ens33 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
echo "Linked interface with BLUE the network: ens33"
echo ""
#Output for DNS servers
echo -n "Current DNS: "
cat /etc/resolv.conf
echo ""
#Order of hostname resolution 
echo -n "hostname: " 
hostname
echo ""
#Output for hostname resolution
echo "Contents of host file: "
cat /etc/hosts
echo ""
#Default-gateway
echo -n "Default gateway: " 
ip route | grep default
echo ""

#Ping testing
echo "Ping results from server to client"
ping -c 4 172.16.31.39 | tail -3
echo ""


#Ping test to default gateway
def=$(ip route | grep default | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
ping -c 4 $def | tail -3
echo ""
