pkg=stage3-dejagnu
src=dejagnu-1.6.3.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg/build
	../configure --prefix=/usr
	makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
	makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

install:V: configure
	installbuild $pkg/build -j$(nproc)
	cd $BUILD/$pkg/build
	install -v -dm755  /usr/share/doc/dejagnu-1.6.3
	install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3
	