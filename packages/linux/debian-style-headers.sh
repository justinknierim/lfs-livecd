#!/bin/sh

SRCDIR="$1"
DSTDIR=/usr/src/`basename "$1"`

echo $SRCDIR $DSTDIR

rm -rf "$DSTDIR"
mkdir "$DSTDIR"
cp -rv "$SRCDIR/.config" "$SRCDIR/Makefile" "$SRCDIR/Module.symvers" "$DSTDIR"
cp -rv "$SRCDIR/.kconfig.d" "$SRCDIR/.version" "$SRCDIR/.kernelrelease" "$DSTDIR"
cp -rv "$SRCDIR/include" "$SRCDIR/scripts" "$DSTDIR"
( cd "$SRCDIR" ; find -type d ) | (
	while read dir ; do
	    mkdir -p "$DSTDIR/$dir"
	done )
( cd "$SRCDIR" ; find -type f -a '(' -name Kconfig\* \
    -o -name Makefile\* -o -name \*.s ')' ) | (
	cd "$SRCDIR"
	while read file ; do
	    cp -v "$file" "$DSTDIR/$file"
	done )
KVERSION=`grep UTS_RELEASE "$SRCDIR/include/linux/version.h" | cut -d '"' -f 2`
ln -nsf "$DSTDIR" "/lib/modules/$KVERSION/source"
ln -nsf "$DSTDIR" "/lib/modules/$KVERSION/build"
