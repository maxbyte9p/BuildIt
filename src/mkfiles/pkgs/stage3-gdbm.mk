pkg=stage3-gdbm
src=gdbm-1.23.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg