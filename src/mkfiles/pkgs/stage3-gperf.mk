pkg=stage3-gperf
src=gperf-3.1.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg