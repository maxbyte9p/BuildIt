pkg=stage3-bc
src=bc-6.0.1.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	CC=gcc ./configure --prefix=/usr -G -O3 -r

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg