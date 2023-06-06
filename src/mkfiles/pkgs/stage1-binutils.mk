</tmp/BSYSPROJ2/environment.mk

pkg=stage1-binutils
src=binutils-2.39.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg/build
	../configure --prefix=$LFS/tools	 \
             --with-sysroot=$LFS			 \
             --target=$LFS_TGT 			 \
             --disable-nls 				 \
             --enable-gprofng=no 			 \
             --disable-werror

build:V: configure
	buildsrc $pkg/build -j$(nproc)

install:V: build
	installbuild $pkg/build
