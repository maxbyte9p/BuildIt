</tmp/BSYSPROJ4/environment.mk

def:V: essentials

mkdirs:V:
	mkdir -pv $LFS/{dev,proc,sys,run}
	mkdir -pv $LFS/{boot,home,mnt,opt,srv}
	mkdir -pv $LFS/etc/{opt,sysconfig}
	mkdir -pv $LFS/lib/firmware
	mkdir -pv $LFS/media/{floppy,cdrom}
	mkdir -pv $LFS/usr/{,local/}{include,src}
	mkdir -pv $LFS/usr/local/{bin,lib,sbin}
	mkdir -pv $LFS/usr/{,local/}share/{color,dict,doc,info,locale,man}
	mkdir -pv $LFS/usr/{,local/}share/{misc,terminfo,zoneinfo}
	mkdir -pv $LFS/usr/{,local/}share/man/man{1..8}
	mkdir -pv $LFS/var/{cache,local,log,mail,opt,spool}
	mkdir -pv $LFS/var/lib/{color,misc,locate}

links:V: mkdirs
	ln -sfv /run /var/run
	ln -sfv /run/lock /var/lock

extras:V: links
	install -dv -m 0750 /root
	install -dv -m 1777 /tmp /var/tmp

passwd_file="
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
systemd-journal-gateway:x:73:73:systemd Journal Gateway:/:/usr/bin/false
systemd-journal-remote:x:74:74:systemd Journal Remote:/:/usr/bin/false
systemd-journal-upload:x:75:75:systemd Journal Upload:/:/usr/bin/false
systemd-network:x:76:76:systemd Network Management:/:/usr/bin/false
systemd-resolve:x:77:77:systemd Resolver:/:/usr/bin/false
systemd-timesync:x:78:78:systemd Time Synchronization:/:/usr/bin/false
systemd-coredump:x:79:79:systemd Core Dumper:/:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
systemd-oom:x:81:81:systemd Out Of Memory Daemon:/:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
"

group_file="
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
systemd-journal:x:23:
input:x:24:
mail:x:34:
kvm:x:61:
systemd-journal-gateway:x:73:
systemd-journal-remote:x:74:
systemd-journal-upload:x:75:
systemd-network:x:76:
systemd-resolve:x:77:
systemd-timesync:x:78:
systemd-coredump:x:79:
uuidd:x:80:
systemd-oom:x:81:
wheel:x:97:
users:x:999:
nogroup:x:65534:
"

hosts_file="
127.0.0.1  localhost astolfo
::1        localhost
"

essentials:V: extras
	ln -sv /proc/self/mounts /etc/mtab
	echo "$passwd_file" > $LFS/etc/passwd 
	echo "$group_file" > $LFS/etc/group
	echo "$hosts_file" > $LFS/etc/hosts
	echo "tester:x:101:101::/home/tester:/bin/bash" >> $LFS/etc/passwd
	echo "tester:x:101:" >> $LFS/etc/group
	mkdir -p $LFS/home/tester
	touch /var/log/{btmp,lastlog,faillog,wtmp}
	chmod -v 664  /var/log/lastlog
	chmod -v 600  /var/log/btmp

#runchroot install -o tester -d /home/tester
#runchroot chgrp -v utmp /var/log/lastlog