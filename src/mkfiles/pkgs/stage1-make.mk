</tmp/BSYSPROJ2/environment.mk

pkg=stage1-make
src=make-4.3.tar.gz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr	   \
		            --without-guile	   \
		            --host=$LFS_TGT	   \
		            --build=$(build-aux/config.guess)

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg DESTDIR=$LFS