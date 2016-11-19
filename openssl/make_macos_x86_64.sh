#!/bin/bash

cwdir=`pwd`
rootdir=`dirname $0`
cd "$rootdir"
rootdir=`pwd`
target=macos_x86_64
prefix=$rootdir/$target
openssldir=$prefix/ssl
version=`cat $rootdir/version.txt`
rm -rf "$rootdir/$version"
mkdir "$rootdir/$version"
cp -rf "$rootdir/../$version/"* "$rootdir/$version"
cd "$rootdir/$version"
./Configure no-shared no-asm no-dso --prefix="$prefix" --openssldir="$openssldir" darwin64-x86_64-cc -m64 -fPIC
make
make install
mkdir "$rootdir/../target/include/$target"
cp -rf "$prefix/include/"* "$rootdir/../target/include/$target"
mkdir "$rootdir/../target/lib/$target"
cp -f "$prefix/lib/"*.a "$rootdir/../target/lib/$target"
cd "$cwdir"
rm -rf "$rootdir/$version"
rm -rf "$prefix"
