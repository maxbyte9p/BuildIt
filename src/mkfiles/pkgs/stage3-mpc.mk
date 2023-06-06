pkg=stage3-mpc
src=mpc-1.2.1.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.2.1

build:V: configure
	buildsrc $pkg -j$(nproc)
	buildsrc $pkg html
	make check -C $BUILD/$pkg

install:V: build
	installbuild $pkg
	make -C $BUILD/$pkg install-html