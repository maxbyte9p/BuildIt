pkg=stage3-libelf
src=elfutils-0.187.tar.bz2

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr                \
            --disable-debuginfod         \
            --enable-libdebuginfod=dummy

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg/libelf
	cd $BUILD/$pkg
	install -vm644 config/libelf.pc /usr/lib/pkgconfig
	rm /usr/lib/libelf.a