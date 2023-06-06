

pkg=stage3-dbus
src=dbus-1.14.0.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr                        \
            --sysconfdir=/etc                    \
            --localstatedir=/var                 \
            --runstatedir=/run                   \
            --disable-static                     \
            --disable-doxygen-docs               \
            --disable-xml-docs                   \
            --docdir=/usr/share/doc/dbus-1.14.0 \
            --with-system-socket=/run/dbus/system_bus_socket

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	ln -sfv /etc/machine-id /var/lib/dbus


