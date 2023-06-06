pkg=stage3-gmp
src=gmp-6.2.1.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.2.1

build:V: configure
	buildsrc $pkg -j$(nproc)
	buildsrc $pkg html
	cd $BUILD/$pkg
	make check 2>&1 | tee gmp-check-log
	awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log

install:V: build
	installbuild $pkg
	make -C $BUILD/$pkg install-html