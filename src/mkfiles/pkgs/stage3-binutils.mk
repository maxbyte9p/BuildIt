pkg=stage3-binutils
src=binutils-2.39.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

test:V: extract
	expect -c "spawn ls"

configure:V: test
	cd $BUILD/$pkg/build
	../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib

build:V: configure
	buildsrc $pkg/build tooldir=/usr -j$(nproc)
	#make -k check -C $BUILD/$pkg/build

install:V: build
	installbuild $pkg/build tooldir=/usr
	rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.a