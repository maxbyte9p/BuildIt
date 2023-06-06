</tmp/BSYSPROJ4/environment.mk

pkg=stage3-iana-etc
src=iana-etc-20220812.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

install:V: extract
	cd $BUILD/$pkg
 	cp services protocols /etc
