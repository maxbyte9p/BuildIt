pkg=stage3-coreutils
src=coreutils-9.1.tar.xz
patch=coreutils-9.1-i18n-1.patch

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	patch -Np1 -i $SOURCES/$patch
	autoreconf -fiv
	FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	mv -v /usr/bin/chroot /usr/sbin
	mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
	sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8