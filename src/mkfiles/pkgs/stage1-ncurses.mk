</tmp/BSYSPROJ2/environment.mk

pkg=stage1-ncurses
src=ncurses-6.3.tar.gz


def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg/build
	../configure
	make -C include
	make -C progs tic
	cd $BUILD/$pkg
	./configure --prefix=/usr                                   \
            		   --host=$LFS_TGT                            \
            		   --build=$(./config.guess)               \
           		   --mandir=/usr/share/man             \
            		   --with-manpage-format=normal  \
            		   --with-shared                                    \
            		   --without-normal                              \
           		   --with-cxx-shared                            \
            		   --without-debug                                \
            		   --without-ada                		   \
            		   --disable-stripping          		   \
           		   --enable-widec

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg DESTDIR=$LFS TIC_PATH=$BUILD/$pkg/build/progs/tic
	echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so