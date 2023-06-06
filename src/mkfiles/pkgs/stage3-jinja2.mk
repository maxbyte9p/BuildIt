

pkg=stage3-jinja2
src=Jinja2-3.1.2.tar.gz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

build:V: extract
	cd $BUILD/$pkg
	pip3 wheel -w dist --no-build-isolation --no-deps $PWD

install:V: build
	cd $BUILD/$pkg
	pip3 install --no-index --no-user --find-links dist Jinja2
