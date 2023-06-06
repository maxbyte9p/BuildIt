</tmp/BSYSPROJ2/environment.mk

pkg=stage1-linux-api-headers
src=linux-5.19.2.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

build:V: extract
	buildsrc $pkg mrproper
	buildsrc $pkg headers

install:V: build
	cd $BUILD/$pkg
	find usr/include -type f ! -name '*.h' -delete
	cp -rv usr/include $LFS/usr