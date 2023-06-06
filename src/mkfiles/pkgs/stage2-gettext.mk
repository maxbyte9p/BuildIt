</tmp/BSYSPROJ4/environment.mk

pkg=stage2-gettext
src=gettext-0.21.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --disable-shared

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	cd $BUILD/$pkg
	cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
	
	

