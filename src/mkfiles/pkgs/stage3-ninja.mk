pkg=stage3-ninja
src=ninja-1.11.0.tar.gz

NINJAJOBS=$(nproc)

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed -i '/int Guess/a \
	  int   j = 0;\
	  char* jobs = getenv( "NINJAJOBS" );\
	  if ( jobs != NULL ) j = atoi( jobs );\
	  if ( j > 0 ) return j;\
	' src/ninja.cc

build:V: configure
	cd $BUILD/$pkg
	python3 configure.py --bootstrap

install:V: build
	cd $BUILD/$pkg
	install -vm755 ninja /usr/bin/
	install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
	install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja
	