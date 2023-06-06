pkg=stage3-check
src=check-0.15.2.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr --disable-static

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg docdir=/usr/share/doc/check-0.15.2