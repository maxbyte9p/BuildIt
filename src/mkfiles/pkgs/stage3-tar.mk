

pkg=stage3-tar
src=tar-1.34.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	FORCE_UNSAFE_CONFIGURE=1  \
	./configure --prefix=/usr

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	make -C $BUILD/$pkg/doc install-html docdir=/usr/share/doc/tar-1.34


