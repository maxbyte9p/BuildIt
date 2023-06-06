pkg=stage3-xz
src=xz-5.2.6.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.2.6

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg