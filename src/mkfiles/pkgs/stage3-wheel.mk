pkg=stage3-wheel
src=wheel-0.37.1.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

install:V: extract
	pip3 install --no-index $BUILD/$pkg