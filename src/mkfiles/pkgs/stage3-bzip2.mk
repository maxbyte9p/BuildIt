pkg=stage3-bzip2
src=bzip2-1.0.8.tar.gz
patch=bzip2-1.0.8-install_docs-1.patch

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	# Same bug as Zlib
	tar -xf $SOURCES/$src --no-same-owner --strip-components=1 -C $BUILD/$pkg

configure:V: extract
	cd $BUILD/$pkg
	patch -Np1 -i $SOURCES/$patch
	sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
	make -f Makefile-libbz2_so
	make clean
	
build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg PREFIX=/usr
	cd $BUILD/$pkg
	cp -av libbz2.so.* /usr/lib
	ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so
	cp -v bzip2-shared /usr/bin/bzip2
	for i in /usr/bin/{bzcat,bunzip2}; do
	  ln -sfv bzip2 $i
	done
	rm -fv /usr/lib/libbz2.a

