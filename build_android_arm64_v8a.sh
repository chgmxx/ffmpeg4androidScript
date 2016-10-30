#!/bin/bash
#Change NDK to your Android NDK location
export NDK=/home/chen/Download/android-ndk-r13
export PLATFORM=$NDK/platforms/android-21/arch-arm64/
export PREBUILT=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64
export PREFIX=./android/arm64-v8a
echo start make clean
make clean
echo finish clean

echo start configure
./configure \
--logfile=conflog.txt \
--target-os=linux \
--prefix=$PREFIX	
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=aarch64 \
--cc=$PREBUILT/bin/aarch64-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/aarch64-linux-android- \
--nm=$PREBUILT/bin/aarch64-linux-android-nm \
--sysroot=$PLATFORM \
--extra-cflags="-DANDROID" \
--extra-ldflags=" -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
--enable-shared \
--disable-static \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-debug \
--disable-doc \
--enable-zlib \
--enable-gpl 
echo finish configure

make -j4
make install

echo Android ARM64 builds finished
