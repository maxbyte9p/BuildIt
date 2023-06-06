

pkg=stage3-kbd
src=kbd-2.5.1.tar.xz
patch=kbd-2.5.1-backspace-1.patch


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	patch -Np1 -i $SOURCES/$patch
	sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
	sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
	./configure --prefix=/usr --disable-vlock

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	cd $BUILD/$pkg
	mkdir -pv           /usr/share/doc/kbd-2.5.1
	cp -R -v docs/doc/* /usr/share/doc/kbd-2.5.1


