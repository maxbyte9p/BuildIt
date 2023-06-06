pkg=stage3-flex
src=flex-2.6.4.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr \
            --docdir=/usr/share/doc/flex-2.6.4 \
            --disable-static

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	ln -sv flex /usr/bin/lex