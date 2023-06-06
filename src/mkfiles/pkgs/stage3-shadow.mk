pkg=stage3-shadow
src=shadow-4.12.2.tar.gz

def:V: install

mkdirs:V:
	prepbuild $pkg

extract:V: mkdirs
	extractsrc $src $pkg

configure:V: extract
	cd $BUILD/$pkg
	sed -i 's/groups$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
	find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
	find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
	sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD SHA512:' \
	    -e 's:/var/spool/mail:/var/mail:'                 \
	    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                \
	    -i etc/login.defs
	touch /usr/bin/passwd
	./configure --sysconfdir=/etc \
            --disable-static  \
            --with-group-name-max-length=32

build:V: configure
	buildsrc $pkg -j$(nproc)

install:V: build
	installbuild $pkg exec_prefix=/usr
	make -C $BUILD/$pkg/man install-man
	pwconv
	grpconv
	mkdir -p /etc/default
	useradd -D --gid 999
	sed -i '/MAIL/s/yes/no/' /etc/default/useradd