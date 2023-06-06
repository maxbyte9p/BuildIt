pkg=stage3-ncurses
src=ncurses-6.3.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --with-cxx-shared       \
            --enable-pc-files       \
            --enable-widec          \
            --with-pkg-config-libdir=/usr/lib/pkgconfig

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg DESTDIR=$BUILD/$pkg/dest
	cd $BUILD/$pkg
	install -vm755 dest/usr/lib/libncursesw.so.6.3 /usr/lib
	rm -v  dest/usr/lib/libncursesw.so.6.3
	cp -av dest/* /
	for lib in ncurses form panel menu ; do
	    rm -vf                    /usr/lib/lib${lib}.so
	    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
	    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
	done
	rm -vf                     /usr/lib/libcursesw.so
	echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
	ln -sfv libncurses.so      /usr/lib/libcurses.so
	mkdir -pv      /usr/share/doc/ncurses-6.3
	cp -v -R doc/* /usr/share/doc/ncurses-6.3