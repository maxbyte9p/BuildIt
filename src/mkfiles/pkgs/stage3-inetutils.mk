pkg=stage3-inetutils
src=inetutils-2.3.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr        \
            --bindir=/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	mv -v /usr/{,s}bin/ifconfig