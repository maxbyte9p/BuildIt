

pkg=stage3-findutils
src=findutils-4.9.0.tar.xz


def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	case $(uname -m) in
	    i?86)   TIME_T_32_BIT_OK=yes ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
	    x86_64) ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
	esac

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg


