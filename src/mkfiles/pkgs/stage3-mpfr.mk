pkg=stage3-mpfr
src=mpfr-4.1.0.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.1.0

build:V: configure
	buildsrc $pkg -j$(nproc)
	buildsrc $pkg html
	make check -C $BUILD/$pkg

install:V: build
	installbuild $pkg
	make -C $BUILD/$pkg install-html