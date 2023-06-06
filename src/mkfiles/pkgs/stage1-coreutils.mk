</tmp/BSYSPROJ2/environment.mk

pkg=stage1-coreutils
src=coreutils-9.1.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	./configure --prefix=/usr	 		                   \
		            --host=$LFS_TGT			                   \
		            --build=$(build-aux/config.guess)	 \
 		           --enable-install-program=hostname	 \
 		           --enable-no-install-program=kill,uptime

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg DESTDIR=$LFS 
	mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin
	mkdir -pv $LFS/usr/share/man/man8
	mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
	sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8