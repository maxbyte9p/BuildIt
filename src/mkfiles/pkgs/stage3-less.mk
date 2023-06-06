pkg=stage3-less
src=less-590.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr --sysconfdir=/etc

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg