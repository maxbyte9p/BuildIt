

pkg=stage3-markupsafe
src=MarkupSafe-2.1.1.tar.gz


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
	pip3 install --no-index --no-user --find-links dist Markupsafe


