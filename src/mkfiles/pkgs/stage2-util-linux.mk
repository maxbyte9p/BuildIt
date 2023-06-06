</tmp/BSYSPROJ4/environment.mk

pkg=stage2-util-linux
src=util-linux-2.38.1.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure ADJTIME_PATH=/var/lib/hwclock/adjtime    \
            --libdir=/usr/lib    \
            --docdir=/usr/share/doc/util-linux-2.38.1 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
	   --disable-wall \
            runstatedir=/run

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg