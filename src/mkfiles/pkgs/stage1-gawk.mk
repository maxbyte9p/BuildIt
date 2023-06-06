</tmp/BSYSPROJ2/environment.mk

pkg=stage1-gawk
src=gawk-5.1.1.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed -i 's/extras//' Makefile.in
	./configure --prefix=/usr	   \
		            --host=$LFS_TGT	   \
		            --build=$(build-aux/config.guess)

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg DESTDIR=$LFS