pkg=stage3-tcl
src=tcl8.6.12-src.tar.gz
docs=tcl8.6.12-html.tar.gz
SRCDIR=$BUILD/$pkg

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg
	extractsrc $docs $pkg

configure:V: extract
	cd $BUILD/$pkg
	cd unix
	./configure --prefix=/usr           \
            --mandir=/usr/share/man

build:V: configure
	buildsrc $pkg/unix -j$(nproc)
	cd $BUILD/$pkg/unix
	sed -e "s|$SRCDIR/unix|/usr/lib|" \
 	   -e "s|$SRCDIR|/usr/include|"  \
	    -i tclConfig.sh
	sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.3|/usr/lib/tdbc1.1.3|" \
	    -e "s|$SRCDIR/pkgs/tdbc1.1.3/generic|/usr/include|"    \
	    -e "s|$SRCDIR/pkgs/tdbc1.1.3/library|/usr/lib/tcl8.6|" \
	    -e "s|$SRCDIR/pkgs/tdbc1.1.3|/usr/include|"            \
	    -i pkgs/tdbc1.1.3/tdbcConfig.sh
	sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.2|/usr/lib/itcl4.2.2|" \
	    -e "s|$SRCDIR/pkgs/itcl4.2.2/generic|/usr/include|"    \
	    -e "s|$SRCDIR/pkgs/itcl4.2.2|/usr/include|"            \
	    -i pkgs/itcl4.2.2/itclConfig.sh

install:V: build
	installbuild $pkg/unix
	cd $BUILD/$pkg/unix
	chmod -v u+w /usr/lib/libtcl8.6.so
	make install-private-headers -C $BUILD/$pkg/unix
	ln -sfv tclsh8.6 /usr/bin/tclsh
	mv /usr/share/man/man3/{Thread,Tcl_Thread}.3
	mkdir -v -p /usr/share/doc/tcl-8.6.12
	cp -v -r  ../html/* /usr/share/doc/tcl-8.6.12
	