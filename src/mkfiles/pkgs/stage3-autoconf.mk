pkg=stage3-autoconf
src=autoconf-2.71.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg