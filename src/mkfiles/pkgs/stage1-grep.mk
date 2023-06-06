</tmp/BSYSPROJ2/environment.mk

pkg=stage1-grep
src=grep-3.7.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr --host=$LFS_TGT

build:V: configure
	buildsrc $pkg -j$(nproc) 

install:V: build
	installbuild $pkg DESTDIR=$LFS