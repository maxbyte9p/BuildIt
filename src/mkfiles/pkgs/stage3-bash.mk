pkg=stage3-bash
src=bash-5.1.16.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr                      \
            --docdir=/usr/share/doc/bash-5.1.16 \
            --without-bash-malloc              \
            --with-installed-readline

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg