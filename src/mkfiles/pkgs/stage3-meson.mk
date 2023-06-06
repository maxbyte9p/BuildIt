pkg=stage3-meson
src=meson-0.63.1.tar.gz

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
	pip3 install --no-index --find-links dist meson
	install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
	install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson
	
	