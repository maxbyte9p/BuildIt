pkg=stage3-acl
src=acl-2.3.1.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr         \
            --disable-static      \
            --docdir=/usr/share/doc/acl-2.3.1

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg