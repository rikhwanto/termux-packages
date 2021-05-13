TERMUX_PKG_HOMEPAGE=https://talloc.samba.org/talloc/doc/html/index.html
TERMUX_PKG_DESCRIPTION="Hierarchical, reference counted memory pool system with destructors"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.3.2
TERMUX_PKG_SRCURL=https://www.samba.org/ftp/talloc/talloc-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=27a03ef99e384d779124df755deb229cd1761f945eca6d200e8cfd9bf5297bd7
TERMUX_PKG_BREAKS="libtalloc-dev"
TERMUX_PKG_REPLACES="libtalloc-dev"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	cat <<EOF > cross-answers.txt
Checking uname sysname type: "Linux"
Checking uname machine type: "dontcare"
Checking uname release type: "dontcare"
Checking uname version type: "dontcare"
Checking simple C program: OK
building library support: OK
Checking for large file support: OK
Checking for -D_FILE_OFFSET_BITS=64: OK
Checking for WORDS_BIGENDIAN: OK
Checking for C99 vsnprintf: OK
Checking for HAVE_SECURE_MKSTEMP: OK
rpath library support: OK
-Wl,--version-script support: FAIL
Checking correct behavior of strtoll: OK
Checking correct behavior of strptime: OK
Checking for HAVE_IFACE_GETIFADDRS: OK
Checking for HAVE_IFACE_IFCONF: OK
Checking for HAVE_IFACE_IFREQ: OK
Checking getconf LFS_CFLAGS: OK
Checking for large file support without additional flags: OK
Checking for working strptime: OK
Checking for HAVE_SHARED_MMAP: OK
Checking for HAVE_MREMAP: OK
Checking for HAVE_INCOHERENT_MMAP: OK
Checking getconf large file support flags work: OK
EOF

	./configure --prefix=$TERMUX_PREFIX \
		--disable-rpath \
		--disable-python \
		--cross-compile \
		--cross-answers=cross-answers.txt
}

termux_step_post_make_install() {
	cd bin/default
	$AR rcu libtalloc.a talloc*.o
	install -Dm600 libtalloc.a \
		$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib/libtalloc.a
}
