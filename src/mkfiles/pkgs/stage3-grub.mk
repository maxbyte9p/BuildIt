

pkg=stage3-grub
src=grub-2.06.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --disable-efiemu       \
            --disable-werror

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg
	mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions


