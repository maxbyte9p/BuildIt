PROGRESS=$LFS/progress

STAGE1=stage1-filesystem stage1-binutils stage1-gcc stage1-linux-api-headers stage1-glibc stage1-libstdc++ stage1-m4 stage1-ncurses stage1-bash stage1-coreutils stage1-diffutils stage1-file stage1-findutils stage1-gawk stage1-grep stage1-gzip stage1-make stage1-patch stage1-sed stage1-tar stage1-xz stage1-p2-binutils stage1-p2-gcc

STAGE2=stage2-filesystem stage2-gettext stage2-bison stage2-perl stage2-python stage2-texinfo stage2-util-linux

STAGE3=stage3-man-pages stage3-iana-etc stage3-glibc stage3-zlib stage3-bzip2 stage3-xz stage3-zstd stage3-file stage3-readline stage3-m4 stage3-bc stage3-flex stage3-tcl stage3-expect stage3-dejagnu stage3-binutils stage3-gmp stage3-mpfr stage3-mpc stage3-attr stage3-acl stage3-libcap stage3-shadow stage3-gcc stage3-pkg-config stage3-ncurses stage3-sed stage3-psmisc stage3-gettext stage3-bison stage3-grep stage3-bash stage3-libtool stage3-gdbm stage3-gperf stage3-expat stage3-inetutils stage3-less stage3-perl stage3-xml-parser stage3-intltool stage3-autoconf stage3-automake stage3-openssl stage3-kmod stage3-libelf stage3-libffi stage3-python stage3-wheel stage3-ninja stage3-meson stage3-coreutils stage3-check stage3-diffutils stage3-gawk stage3-findutils stage3-groff stage3-grub stage3-gzip stage3-iproute stage3-kbd stage3-libpipeline stage3-make stage3-patch stage3-tar stage3-texinfo stage3-vim stage3-markupsafe stage3-jinja2 stage3-systemd stage3-dbus stage3-mandb stage3-procps-ng stage3-util-linux stage3-e2fsprogs

STAGE4=stage4-config-files stage4-linux

ALL=stage4

def:V: $ALL

$PROGRESS/%: 
	if [[ "$stem" =~ "stage1" ]]; then
		buildpkg $stem
	elif [[ "$stem" =~ "stage2" ]] || [[ "$stem" =~ "stage3" ]] || [[ "$stem" =~ "stage4" ]]; then
		CHROOT=1 buildpkg $stem
	fi
	mkdir -p $PROGRESS
	touch $target

stage1:V: $STAGE1

stage2:V: $STAGE2

stage3:V: $STAGE3

stage4:V: $STAGE4

clean:V:
	rm -rf $LFS

stage1-filesystem:V: $PROGRESS/stage1-filesystem

stage1-binutils:V: stage1-filesystem $PROGRESS/stage1-binutils

stage1-gcc:V: stage1-binutils $PROGRESS/stage1-gcc

stage1-linux-api-headers:V: stage1-gcc $PROGRESS/stage1-linux-api-headers

stage1-glibc:V: stage1-linux-api-headers $PROGRESS/stage1-glibc

stage1-libstdc++:V: stage1-glibc $PROGRESS/stage1-libstdc++

stage1-m4:V: stage1-libstdc++ $PROGRESS/stage1-m4

stage1-ncurses:V: stage1-m4 $PROGRESS/stage1-ncurses

stage1-bash:V: stage1-ncurses $PROGRESS/stage1-bash

stage1-coreutils:V: stage1-bash $PROGRESS/stage1-coreutils

stage1-diffutils:V: stage1-coreutils $PROGRESS/stage1-diffutils

stage1-file:V: stage1-diffutils $PROGRESS/stage1-file

stage1-findutils:V: stage1-file $PROGRESS/stage1-findutils

stage1-gawk:V: stage1-findutils $PROGRESS/stage1-gawk

stage1-grep:V: stage1-gawk $PROGRESS/stage1-grep

stage1-gzip:V: stage1-grep $PROGRESS/stage1-gzip

stage1-make:V: stage1-gzip $PROGRESS/stage1-make

stage1-patch:V: stage1-make $PROGRESS/stage1-patch

stage1-sed:V: stage1-patch $PROGRESS/stage1-sed

stage1-tar:V: stage1-sed $PROGRESS/stage1-tar

stage1-xz:V: stage1-tar $PROGRESS/stage1-xz

stage1-p2-binutils:V: stage1-xz $PROGRESS/stage1-p2-binutils

stage1-p2-gcc:V: stage1-binutils $PROGRESS/stage1-p2-gcc

stage2-filesystem:V: stage1 $PROGRESS/stage2-filesystem

stage2-gettext:V: stage2-filesystem $PROGRESS/stage2-gettext

stage2-bison:V: stage2-gettext $PROGRESS/stage2-bison

stage2-perl:V: stage2-bison $PROGRESS/stage2-perl

stage2-python:V: stage2-perl $PROGRESS/stage2-python

stage2-texinfo:V: stage2-python $PROGRESS/stage2-texinfo

stage2-util-linux:V: stage2-texinfo $PROGRESS/stage2-util-linux

stage3-man-pages:V: stage2 $PROGRESS/stage3-man-pages

stage3-iana-etc:V: stage3-man-pages $PROGRESS/stage3-iana-etc

stage3-glibc:V: stage3-iana-etc $PROGRESS/stage3-glibc

stage3-zlib:V: stage3-glibc $PROGRESS/stage3-zlib

stage3-bzip2:V: stage3-zlib $PROGRESS/stage3-bzip2

stage3-xz:V: stage3-bzip2 $PROGRESS/stage3-xz

stage3-zstd:V: stage3-xz $PROGRESS/stage3-zstd

stage3-file:V: stage3-zstd $PROGRESS/stage3-file

stage3-readline:V: stage3-file $PROGRESS/stage3-readline

stage3-m4:V: stage3-readline $PROGRESS/stage3-m4

stage3-bc:V: stage3-m4 $PROGRESS/stage3-bc

stage3-flex:V: stage3-bc $PROGRESS/stage3-flex

stage3-tcl:V: stage3-flex $PROGRESS/stage3-tcl

stage3-expect:V: stage3-tcl $PROGRESS/stage3-expect

stage3-dejagnu:V: stage3-expect $PROGRESS/stage3-dejagnu

stage3-binutils:V: stage3-dejagnu $PROGRESS/stage3-binutils

stage3-gmp:V: stage3-binutils $PROGRESS/stage3-gmp

stage3-mpfr:V: stage3-gmp $PROGRESS/stage3-mpfr

stage3-mpc:V: stage3-mpfr $PROGRESS/stage3-mpc

stage3-attr:V: stage3-mpc $PROGRESS/stage3-attr

stage3-acl:V: stage3-attr $PROGRESS/stage3-acl

stage3-libcap:V: stage3-acl $PROGRESS/stage3-libcap

stage3-shadow:V: stage3-libcap $PROGRESS/stage3-shadow

stage3-gcc:V: stage3-shadow $PROGRESS/stage3-gcc

stage3-pkg-config:V: stage3-gcc $PROGRESS/stage3-pkg-config

stage3-ncurses:V: stage3-pkg-config $PROGRESS/stage3-ncurses

stage3-sed:V: stage3-ncurses $PROGRESS/stage3-sed

stage3-psmisc:V: stage3-sed $PROGRESS/stage3-psmisc

stage3-gettext:V: stage3-psmisc $PROGRESS/stage3-gettext

stage3-bison:V: stage3-gettext $PROGRESS/stage3-bison

stage3-grep:V: stage3-bison $PROGRESS/stage3-grep

stage3-bash:V: stage3-grep $PROGRESS/stage3-bash

stage3-libtool:V: stage3-bash $PROGRESS/stage3-libtool

stage3-gdbm:V: stage3-libtool $PROGRESS/stage3-gdbm

stage3-gperf:V: stage3-gdbm $PROGRESS/stage3-gperf

stage3-expat:V: stage3-gperf $PROGRESS/stage3-expat

stage3-inetutils:V: stage3-expat $PROGRESS/stage3-inetutils

stage3-less:V: stage3-inetutils $PROGRESS/stage3-less

stage3-perl:V: stage3-less $PROGRESS/stage3-perl

stage3-xml-parser:V: stage3-perl $PROGRESS/stage3-xml-parser

stage3-intltool:V: stage3-xml-parser $PROGRESS/stage3-intltool

stage3-autoconf:V: stage3-intltool $PROGRESS/stage3-autoconf

stage3-automake:V: stage3-autoconf $PROGRESS/stage3-automake

stage3-openssl:V: stage3-automake $PROGRESS/stage3-openssl

stage3-kmod:V: stage3-openssl $PROGRESS/stage3-kmod

stage3-libelf:V: stage3-kmod $PROGRESS/stage3-libelf

stage3-libffi:V: stage3-libelf $PROGRESS/stage3-libffi

stage3-python:V: stage3-libffi $PROGRESS/stage3-python

stage3-wheel:V: stage3-python $PROGRESS/stage3-wheel

stage3-ninja:V: stage3-wheel $PROGRESS/stage3-ninja

stage3-meson:V: stage3-ninja $PROGRESS/stage3-meson

stage3-coreutils:V: stage3-meson $PROGRESS/stage3-coreutils

stage3-check:V: stage3-coreutils $PROGRESS/stage3-check

stage3-diffutils:V: stage3-check $PROGRESS/stage3-diffutils

stage3-gawk:V: stage3-diffutils $PROGRESS/stage3-gawk

stage3-findutils:V: stage3-gawk $PROGRESS/stage3-findutils

stage3-groff:V: stage3-findutils $PROGRESS/stage3-groff

stage3-grub:V: stage3-groff $PROGRESS/stage3-grub

stage3-gzip:V: stage3-grub $PROGRESS/stage3-gzip

stage3-iproute:V: stage3-gzip $PROGRESS/stage3-iproute

stage3-kbd:V: stage3-iproute $PROGRESS/stage3-kbd

stage3-libpipeline:V: stage3-kbd $PROGRESS/stage3-libpipeline

stage3-make:V: stage3-libpipeline $PROGRESS/stage3-make

stage3-patch:V: stage3-make $PROGRESS/stage3-patch

stage3-tar:V: stage3-patch $PROGRESS/stage3-tar

stage3-texinfo:V: stage3-tar $PROGRESS/stage3-texinfo

stage3-vim:V: stage3-texinfo $PROGRESS/stage3-vim

stage3-markupsafe:V: stage3-vim $PROGRESS/stage3-markupsafe

stage3-jinja2:V: stage3-markupsafe $PROGRESS/stage3-jinja2

stage3-systemd:V: stage3-jinja2 $PROGRESS/stage3-systemd

stage3-dbus:V: stage3-systemd $PROGRESS/stage3-dbus

stage3-mandb:V: stage3-dbus $PROGRESS/stage3-mandb

stage3-procps-ng:V: stage3-mandb $PROGRESS/stage3-procps-ng

stage3-util-linux:V: stage3-procps-ng $PROGRESS/stage3-util-linux

stage3-e2fsprogs:V: stage3-util-linux $PROGRESS/stage3-e2fsprogs

stage4-config-files:V: stage3 $PROGRESS/stage4-config-files

stage4-linux:V: stage4-config-files $PROGRESS/stage4-linux