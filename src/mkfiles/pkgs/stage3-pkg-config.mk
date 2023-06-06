pkg=stage3-pkg-config
src=pkg-config-0.29.2.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr              \
            --with-internal-glib       \
            --disable-host-tool        \
            --docdir=/usr/share/doc/pkg-config-0.29.2

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg