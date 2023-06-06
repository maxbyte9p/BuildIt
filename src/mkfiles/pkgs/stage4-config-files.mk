def:V: systemd_config

ether0_mac="$(cat /sys/class/net/eth0/address)"
ether0_link="
[Match]
# Change the MAC address as appropriate for your network device
MACAddress=$ether0_mac

[Link]
Name=ether0
"

network-device-naming:V:
	ln -s /dev/null /etc/systemd/network/99-default.link
	echo "$ether0_link" > /etc/systemd/network/10-ether0.link

ether_static_network="
[Match]
Name=ether0

[Network]
Address=192.168.0.2/24
Gateway=192.168.0.1
"

ip-config:V: network-device-naming
	echo "$ether_static_network" > /etc/systemd/network/10-eth-static.network

ether_dhcp_config="
[Match]
Name=ether0

[Network]
DHCP=ipv4

[DHCP]
UseDomains=true
"

dhcp-config:V: ip-config
	echo "$ether_dhcp_config" > /etc/systemd/network/10-eth-dhcp.network

hostname:V: dhcp-config
	echo "astolfo" > /etc/hostname

hosts_config="
# Begin /etc/hosts

127.0.0.1		localhost.localdomain localhost
127.0.1.1		astolfo astolfo
::1		         localhost ip6-localhost ip6-loopback
ff02::1		ip6-allnodes
ff02::2	         ip6-allrouters

# End /etc/hosts
"

hosts:V: hostname
	echo "$hosts_config" > /etc/hosts

adjtime_file="
0.0 0 0.0
0
LOCAL
"

sysclock:V: hosts
	echo "$adjtime_file" > /etc/adjtime

inputrc_file="
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8-bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
"

inputrc:V: sysclock
	echo "$inputrc_file" > /etc/inputrc

shells_file="
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
"

shells:V: inputrc
	echo "$shells_file" > /etc/shells

noclear_conf_file="
[Service]
TTYVTDisallocate=no
"

coredump_conf_file="
[Coredump]
MaxUse=5G
"

systemd_config:V: shells
	mkdir -pv /etc/systemd/system/getty@tty1.service.d
	echo "$noclear_conf_file" > /etc/systemd/system/getty@tty1.service.d/noclear.conf
	ln -sfv /dev/null /etc/systemd/system/tmp.mount
	mkdir -pv /etc/systemd/coredump.conf.d
	echo "$coredump_conf_file" > /etc/systemd/coredump.conf.d/maxuse.conf
	

