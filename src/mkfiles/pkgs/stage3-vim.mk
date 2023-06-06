

pkg=stage3-vim
src=vim-9.0.0228.tar.gz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	./configure --prefix=/usr

build:V: configure
	buildsrc $pkg -j$(nproc)

vimrc='
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
'

install:V: build
	installbuild $pkg
	ln -sv vim /usr/bin/vi
	for L in  /usr/share/man/{,*/}man1/vim.1; do
	    ln -sv vim.1 $(dirname $L)/vi.1
	done
	ln -sv ../vim/vim90/doc /usr/share/doc/vim-9.0.0228
	echo "$vimrc" > /etc/vimrc


