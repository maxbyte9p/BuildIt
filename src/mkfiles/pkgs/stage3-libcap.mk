pkg=stage3-libcap
src=libcap-2.65.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed -i '/install -m.*STA/d' libcap/Makefile

build:V: configure
	buildsrc $pkg -j$(nproc) prefix=/usr lib=lib

install:V: build
	installbuild $pkg prefix=/usr lib=lib install