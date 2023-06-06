pkg=stage3-zlib
src=zlib-1.2.12.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	# There's a bug with ownership preservation on this archive.
	# BUG: Cannot change ownership to uid 501, gid 20: Invalid argument 
	tar -xf $SOURCES/$src --no-same-owner --strip-components=1 -C $BUILD/$pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	rm -fv /usr/lib/libz.a