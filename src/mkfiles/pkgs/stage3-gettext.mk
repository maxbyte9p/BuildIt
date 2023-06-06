pkg=stage3-gettext
src=gettext-0.21.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.21

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	chmod -v 0755 /usr/lib/preloadable_libintl.so