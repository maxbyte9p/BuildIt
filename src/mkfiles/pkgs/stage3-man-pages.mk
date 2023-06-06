</tmp/BSYSPROJ4/environment.mk

pkg=stage3-man-pages
src=man-pages-5.13.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

install:V: extract
	installbuild $pkg prefix=/usr