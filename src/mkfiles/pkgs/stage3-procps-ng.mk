

pkg=stage3-procps-ng
src=procps-ng-4.0.0.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr                            \
            --docdir=/usr/share/doc/procps-ng-4.0.0 \
            --disable-static                         \
            --disable-kill                           \
            --with-systemd

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg


