pkg=stage3-attr
src=attr-2.5.1.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr     \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.5.1

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg