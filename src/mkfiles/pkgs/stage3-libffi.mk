pkg=stage3-libffi
src=libffi-3.4.2.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr          \
            --disable-static       \
            --with-gcc-arch=native \
            --disable-exec-static-tramp

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg