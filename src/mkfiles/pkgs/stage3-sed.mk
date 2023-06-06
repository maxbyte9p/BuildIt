pkg=stage3-sed
src=sed-4.8.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr

build:V: configure
	buildsrc $pkg -j$(nproc)
	buildsrc $pkg html

install:V: build
	installbuild $pkg
	cd $BUILD/$pkg
	install -d -m755           /usr/share/doc/sed-4.8
	install -m644 doc/sed.html /usr/share/doc/sed-4.8