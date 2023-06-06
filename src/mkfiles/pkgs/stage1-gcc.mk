</tmp/BSYSPROJ2/environment.mk

pkg=stage1-gcc
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
	    sed -e '/m64=/s/lib64/lib/' \
	        -i.orig gcc/config/i386/t-linux64
	 ;;
	esac
	cd $BUILD/$pkg/build
	../configure                                 \
	    --target=$LFS_TGT               \
	    --prefix=$LFS/tools              \
	    --with-glibc-version=2.36  \
	    --with-sysroot=$LFS            \
	    --with-newlib                        \
	    --without-headers                \
	    --disable-nls                          \
	    --disable-shared                   \
	    --disable-multilib                  \
	    --disable-decimal-float       \
	    --disable-threads                  \
	    --disable-libatomic               \
	    --disable-libgomp                 \
	    --disable-libquadmath          \
	    --disable-libssp                      \
	    --disable-libvtv                       \
	    --disable-libstdcxx                 \
	    --enable-languages=c,c++
	
build:V: configure
	buildsrc $pkg/build -j$(nproc)

install:V: build
	installbuild $pkg/build
	cd $BUILD/$pkg
	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h