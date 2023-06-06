</tmp/BSYSPROJ2/environment.mk

pkg=stage1-p2-binutils
src=binutils-2.39.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed '6009s/$add_dir//' -i ltmain.sh
	cd $BUILD/$pkg/build
	../configure                                        \
		    --prefix=/usr                       \
		    --build=$(../config.guess) \
 		    --host=$LFS_TGT                \
		    --disable-nls                        \
		    --enable-shared                  \
		    --enable-gprofng=no         \
		    --disable-werror                 \
		    --enable-64-bit-bfd

build:V: configure
	buildsrc $pkg/build -j$(nproc)

install:V: build
	installbuild $pkg/build DESTDIR=$LFS
	rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}
