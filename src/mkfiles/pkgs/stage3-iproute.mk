

pkg=stage3-iproute
src=iproute2-5.19.0.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed -i /ARPD/d Makefile
	rm -fv man/man8/arpd.8

build:V: configure
	buildsrc $pkg -j$(nproc) NETNS_RUN_DIR=/run/netns

install:V: build
	installbuild $pkg SBINDIR=/usr/sbin
	cd $BUILD/$pkg
	mkdir -pv             /usr/share/doc/iproute2-5.19.0
	cp -v COPYING README* /usr/share/doc/iproute2-5.19.0


