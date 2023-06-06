pkg=stage3-gawk
src=gawk-5.1.1.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed -i 's/extras//' Makefile.in
	./configure --prefix=/usr
	
build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	cd $BUILD/$pkg
	mkdir -pv                                   /usr/share/doc/gawk-5.1.1
	cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.1.1