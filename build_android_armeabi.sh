#!/bin/bash
#Change NDK to your Android NDK location
export NDK=/home/chen/Download/android-ndk-r13
export PLATFORM=$NDK/platforms/android-21/arch-arm/
export PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
export PREFIX=./android/armeabi
echo start make arch-arm clean
make clean
echo finish clean

echo start configure arch-arm


  ./configure \
--logfile=conflog.txt \
  --target-os=linux \
--prefix=$PREFIX	
    --enable-small \
    --enable-cross-compile \
    --extra-libs="-lgcc" \
    --arch=arm \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm \
  --sysroot=$PLATFORM \
--extra-cflags="-DANDROID" \
  --extra-ldflags=" -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog -lz" \
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



echo Android ARMEABI builds finished
