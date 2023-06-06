</tmp/BSYSPROJ2/environment.mk

pkg=stage1-bash
src=bash-5.1.16.tar.gz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr                                  \
		            --build=$(support/config.guess) \
		            --host=$LFS_TGT                           \
		            --without-bash-malloc

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg DESTDIR=$LFS
	ln -sv bash $LFS/bin/sh