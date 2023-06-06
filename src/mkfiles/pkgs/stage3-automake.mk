pkg=stage3-automake
src=automake-1.16.5.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.5

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg