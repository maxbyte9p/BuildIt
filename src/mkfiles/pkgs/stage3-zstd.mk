pkg=stage3-zstd
src=zstd-1.5.2.tar.gz
patch=zstd-1.5.2-upstream_fixes-1.patch

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	patch -Np1 -i $SOURCES/$patch

build:V: configure
	buildsrc $pkg prefix=/usr -j$(nproc)

install:V: build
	installbuild $pkg prefix=/usr
	rm -v /usr/lib/libzstd.a