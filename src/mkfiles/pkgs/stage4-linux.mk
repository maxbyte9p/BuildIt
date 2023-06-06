

pkg=stage4-linux
src=linux-5.19.2.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	make mrproper
	make menuconfig
#	make defconfig

build:V: configure
	buildsrc $pkg -j$(nproc)

usb_conf="
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
"

install:V: build
	cd $BUILD/$pkg
	make modules_install
	cp -iv arch/x86_64/boot/bzImage /boot/vmlinuz-5.19.2-lfs-11.2-systemd
	cp -iv System.map /boot/System.map-5.19.2
	cp -iv .config /boot/config-5.19.2
	install -d /usr/share/doc/linux-5.19.2
	cp -r Documentation/* /usr/share/doc/linux-5.19.2
	install -v -m755 -d /etc/modprobe.d
	echo "$usb_conf" > /etc/modprobe.d/usb.conf


