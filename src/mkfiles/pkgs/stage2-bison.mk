</tmp/BSYSPROJ4/environment.mk

pkg=stage2-bison
src=bison-3.8.2.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	 ./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.8.2

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg