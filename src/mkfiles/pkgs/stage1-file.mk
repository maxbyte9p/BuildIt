</tmp/BSYSPROJ2/environment.mk

pkg=stage1-file
src=file-5.42.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg/build
	../configure --disable-bzlib	      \
	                    --disable-libseccomp \
	                    --disable-xzlib	      \
	                    --disable-zlib
 	make
	cd $BUILD/$pkg
	./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

build:V: configure
	buildsrc $pkg FILE_COMPILE=$BUILD/$pkg/build/src/file

install:V: build
	installbuild $pkg DESTDIR=$LFS
	rm -v $LFS/usr/lib/libmagic.la