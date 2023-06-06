</tmp/BSYSPROJ2/environment.mk

def:V: $LFS/sources

mkdirs:V:
	mkdir $LFS
	mkdir $LFS/boot
	mkdir -p $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
	for i in bin lib sbin ; do
	    ln -s usr/$i $LFS/$i
	done
	case $(uname -m) in
	    x86_64) mkdir -p $LFS/lib64 ;;
	esac
	mkdir -p $LFS/tools
	#mkdir -p $LFS/sources
	
	#cp -R $WORK/sources/* $LFS/sources

$LFS/sources: mkdirs
	dl-srcs