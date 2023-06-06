

pkg=stage3-groff
src=groff-1.22.4.tar.gz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	PAGE=letter ./configure --prefix=/usr

build:V: configure
	buildsrc $pkg -j1

install:V: build
	installbuild $pkg


