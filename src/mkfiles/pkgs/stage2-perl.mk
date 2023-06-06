</tmp/BSYSPROJ4/environment.mk

pkg=stage2-perl
src=perl-5.36.0.tar.xz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg; 
	sh Configure -des                                                                            \
								-Dprefix=/usr                                                           \
             							-Dvendorprefix=/usr                                               \
             							-Dprivlib=/usr/lib/perl5/5.36/core_perl             \
             							-Darchlib=/usr/lib/perl5/5.36/core_perl	    \
             							-Dsitelib=/usr/lib/perl5/5.36/site_perl		    \
             							-Dsitearch=/usr/lib/perl5/5.36/site_perl	    \
             							-Dvendorlib=/usr/lib/perl5/5.36/vendor_perl    \
             							-Dvendorarch=/usr/lib/perl5/5.36/vendor_perl

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg