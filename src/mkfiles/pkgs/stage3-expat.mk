pkg=stage3-expat
src=expat-2.5.0.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.4.8

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	cd $BUILD/$pkg
	install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.4.8