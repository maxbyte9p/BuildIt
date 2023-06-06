</tmp/BSYSPROJ2/environment.mk

pkg=stage1-p2-gcc
src=gcc-12.2.0.tar.xz
src_mpfr=mpfr-4.1.0.tar.xz
src_gmp=gmp-6.2.1.tar.xz
src_mpc=mpc-1.2.1.tar.gz


def:V: install

mkdirs:V:
	prepbuild $pkg/build
	prepbuild $pkg/mpfr
	prepbuild $pkg/gmp
	prepbuild $pkg/mpc

extract:V: mkdirs
	extractsrc $src $pkg
	extractsrc $src_mpfr $pkg/mpfr
	extractsrc $src_gmp $pkg/gmp
	extractsrc $src_mpc $pkg/mpc

configure:V: extract
	cd $BUILD/$pkg
	case $(uname -m) in
	  x86_64)
	    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
	  ;;
	esac
	sed '/thread_header =/s/@.*@/gthr-posix.h/' \
	    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in
	cd $BUILD/$pkg/build
	../configure                                                                                       \
		    --build=$(../config.guess)                                                 \
		    --host=$LFS_TGT                                                                \
		    --target=$LFS_TGT                                                             \
		    LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc      \
		    --prefix=/usr                                                                        \
		    --with-build-sysroot=$LFS                                                \
		    --enable-initfini-array                                                        \
		    --disable-nls                                                                         \
		    --disable-multilib                                                                 \
 		    --disable-decimal-float                                                       \
		    --disable-libatomic                            			            \
		    --disable-libgomp                                                                \
		    --disable-libquadmath                                                         \
		    --disable-libssp                                                                     \
		    --disable-libvtv                                                                      \
		    --enable-languages=c,c++
	
build:V: configure
	buildsrc $pkg/build -j$(nproc)

install:V: build
	installbuild $pkg/build DESTDIR=$LFS
	ln -sv gcc $LFS/usr/bin/cc