pkg=stage3-openssl
src=openssl-3.0.5.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	cd $BUILD/$pkg
	sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
	installbuild $pkg MANSUFFIX=ssl
	mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.0.5
	cp -vfr doc/* /usr/share/doc/openssl-3.0.5