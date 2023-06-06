pkg=stage3-expect
src=expect5.45.4.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib