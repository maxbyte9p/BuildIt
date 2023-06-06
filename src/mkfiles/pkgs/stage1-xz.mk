</tmp/BSYSPROJ2/environment.mk

pkg=stage1-xz
src=xz-5.2.6.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr                                      \
		            --host=$LFS_TGT                               \
		            --build=$(build-aux/config.guess) \
		            --disable-static                                   \
		            --docdir=/usr/share/doc/xz-5.2.6

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg DESTDIR=$LFS
	rm -v $LFS/usr/lib/liblzma.la
