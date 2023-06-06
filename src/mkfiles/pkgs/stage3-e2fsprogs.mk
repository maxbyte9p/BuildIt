

pkg=stage3-e2fsprogs
src=e2fsprogs-1.46.5.tar.gz


def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg/build
	../configure --prefix=/usr           \
             --sysconfdir=/etc       \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck

build:V: configure
	buildsrc $pkg/build -j$(nproc)

install:V: build
	installbuild $pkg/build
	rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
	gunzip -v /usr/share/info/libext2fs.info.gz
	install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info
	cd $BUILD/$pkg/build
	makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
	install -v -m644 doc/com_err.info /usr/share/info
	install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info


