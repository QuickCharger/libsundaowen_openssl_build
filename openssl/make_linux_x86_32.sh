#!/bin/bash

cwdir=`pwd`
rootdir=`dirname "$0"`
cd "$rootdir"
rootdir=`pwd`
tmpdir=/tmp/libsundaowen_openssl
target=linux_x86_32
prefix=$tmpdir/$target
openssldir=$prefix/ssl
version=`cat "$rootdir/version.txt"`
rm -rf "$tmpdir/$version"
mkdir -p "$tmpdir/$version"
cp -rf "$rootdir/../$version/"* "$tmpdir/$version"
cd "$tmpdir/$version"
./Configure no-shared no-asm no-dso --prefix="$prefix" --openssldir="$openssldir" linux-generic32 -m32 -fPIC
make
make install
mkdir -p "$rootdir/../target/include/$target"
cp -rf "$prefix/include/"* "$rootdir/../target/include/$target"
mkdir -p "$rootdir/../target/lib/$target"
cp -f "$prefix/lib/"*.a "$rootdir/../target/lib/$target"
cd "$cwdir"
rm -rf "$tmpdir"
rm -rf "$prefix"
