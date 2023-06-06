pkg=stage3-kmod
src=kmod-30.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --with-openssl         \
            --with-xz              \
            --with-zstd            \
            --with-zlib

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	for t in depmod insmod modinfo modprobe rmmod; do
	  ln -sfv ../bin/kmod /usr/sbin/$t
	done
	ln -sfv kmod /usr/bin/lsmod