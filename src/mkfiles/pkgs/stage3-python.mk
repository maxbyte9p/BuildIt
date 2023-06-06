pkg=stage3-python
src=Python-3.10.6.tar.xz
docs=python-3.10.6-docs-html.tar.bz2

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr        \
            --enable-shared      \
            --with-system-expat  \
            --with-system-ffi    \
            --enable-optimizations

build:V: configure
	buildsrc $pkg -j$(nproc)

pip_conf="
[global]
root-user-action = ignore
disable-pip-version-check = true
"

install:V: build
	installbuild $pkg
	echo "$pip_conf" > /etc/pip.conf
	install -v -dm755 /usr/share/doc/python-3.10.6/html
	tar --strip-components=1  \
	    --no-same-owner       \
	    --no-same-permissions \
	    -C /usr/share/doc/python-3.10.6/html \
	    -xvf $SOURCES/$docs