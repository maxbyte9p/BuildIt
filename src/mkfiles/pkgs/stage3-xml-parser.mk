pkg=stage3-xml-parser
src=XML-Parser-2.46.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	perl Makefile.PL

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg