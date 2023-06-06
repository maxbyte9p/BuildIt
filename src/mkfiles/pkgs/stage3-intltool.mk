pkg=stage3-intltool
src=intltool-0.51.0.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed -i 's:\\\${:\\\$\\{:' intltool-update.in
	./configure --prefix=/usr

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	cd $BUILD/$pkg
	install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO