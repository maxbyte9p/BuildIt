</tmp/BSYSPROJ2/environment.mk

pkg=stage1-libstdc++
src=gcc-12.2.0.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg/build
	../libstdc++-v3/configure            \
	    --host=$LFS_TGT                     \
	    --build=$(../config.guess)      \
	    --prefix=/usr                           \
	    --disable-multilib                   \
	    --disable-nls                           \
	    --disable-libstdcxx-pch       \
	    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/12.2.0

build:V: configure
	buildsrc $pkg/build -j$(nproc)

install:V: build
	installbuild $pkg/build DESTDIR=$LFS
	rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la