

pkg=stage3-systemd
src=systemd-251.tar.gz
patch=systemd-251-glibc_2.36_fix-1.patch
docs=systemd-man-pages-251.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg/build

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	patch -Np1 -i $SOURCES/$patch
	sed -i -e 's/GROUP="render"/GROUP="video"/' \
       -e 's/GROUP="sgx", //' rules.d/50-udev-default.rules.in
	cd $BUILD/$pkg/build
	meson --prefix=/usr                 \
      --buildtype=release           \
      -Ddefault-dnssec=no           \
      -Dfirstboot=false             \
      -Dinstall-tests=false         \
      -Dldconfig=false              \
      -Dsysusers=false              \
      -Drpmmacrosdir=no             \
      -Dhomed=false                 \
      -Duserdb=false                \
      -Dman=false                   \
      -Dmode=release                \
      -Dpamconfdir=no               \
      -Ddocdir=/usr/share/doc/systemd-251 \
      ..
	
build:V: configure
	ninja -C $BUILD/$pkg/build -j$(nproc)

install:V: build
	ninja install -C $BUILD/$pkg/build
	tar -xf $SOURCES/$docs --strip-components=1 -C /usr/share/man
	systemd-machine-id-setup
	systemctl preset-all
	systemctl disable systemd-sysupdate