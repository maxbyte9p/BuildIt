pkg=stage3-readline
src=readline-8.1.2.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install
	./configure --prefix=/usr    \
            --disable-static \
            --with-curses    \
            --docdir=/usr/share/doc/readline-8.1.2

build:V: configure
	buildsrc $pkg SHLIB_LIBS="-lncursesw" -j$(nproc)

install:V: build
	installbuild $pkg SHLIB_LIBS="-lncursesw"
	cd $BUILD/$pkg
	install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.1.2