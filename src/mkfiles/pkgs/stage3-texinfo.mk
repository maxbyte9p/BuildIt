

pkg=stage3-texinfo
src=texinfo-6.8.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	make -C $BUILD/$pkg TEXMF=/usr/share/texmf install-tex
	cd /usr/share/info
	rm -v dir
	for f in *
	  do install-info $f dir 2>/dev/null
	done


