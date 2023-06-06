

pkg=stage3-libpipeline
src=libpipeline-1.5.6.tar.gz


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

install:V: build
	installbuild $pkg


