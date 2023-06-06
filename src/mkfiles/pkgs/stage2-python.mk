</tmp/BSYSPROJ4/environment.mk

pkg=stage2-python
src=Python-3.10.6.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr --enable-shared --without-ensurepip

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg