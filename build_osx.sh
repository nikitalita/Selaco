#!/bin/bash

#quit upon error
set -e

GZDOOMCONFIG="-DCMAKE_BUILD_TYPE=Release -DOSX_COCOA_BACKEND=OFF -DOPENAL_SOFT_VCPKG=ON -DLIBVPX_VCPKG=ON -DSDL2_VCPKG=ON -DZMUSIC_VCPKG=ON -DFORCE_INTERNAL_JPEG=ON -DFORCE_INTERNAL_BZIP2=ON -DFORCE_INTERNAL_ZLIB=ON"
TOOLCHAIN_FILE=/Users/nikita/workspace/vcpkg/scripts/buildsystems/vcpkg.cmake
NPROC=$(sysctl -n hw.ncpu)

X86_DEPLOY_TARGET=10.15
ARM64_DEPLOY_TARGET=11.0
ARM64_ARGS="-DTARGET_ARCHITECTURE=arm64 -DCMAKE_OSX_ARCHITECTURES=arm64 -DVCPKG_TARGET_TRIPLET=arm64-osx-11 -DCMAKE_OSX_DEPLOYMENT_TARGET=$ARM64_DEPLOY_TARGET -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE $GZDOOMCONFIG"
X86_ARGS="-DTARGET_ARCHITECTURE=x86_64 -DCMAKE_OSX_ARCHITECTURES=x86_64 -DVCPKG_TARGET_TRIPLET=x64-osx-10-15 -DCMAKE_OSX_DEPLOYMENT_TARGET=$X86_DEPLOY_TARGET -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE $GZDOOMCONFIG"

mkdir -p build_arm64
cd build_arm64
rm -f build_arm64/Selaco.app/Contents/MacOS/Selaco
echo "Building for arm64"
echo $ARM64_ARGS
cmake $ARM64_ARGS ..
cmake --build . --parallel $NPROC
cd ..

mkdir -p build_x86_64
cd build_x86_64
rm -f build_x86_64/Selaco.app/Contents/MacOS/Selaco
echo "Building for x86_64"
echo $X86_ARGS
cmake $X86_ARGS ..
cmake --build . --parallel $NPROC
cd ..

# now lipo them together
# move it into the arm64 folder
rm -rf build_universal
mkdir -p build_universal
cp -r build_arm64/Selaco.app build_universal/Selaco.app
rm -f build_universal/Selaco.app/Contents/MacOS/Selaco
lipo -create build_arm64/Selaco.app/Contents/MacOS/Selaco build_x86_64/Selaco.app/Contents/MacOS/Selaco -output build_universal/Selaco.app/Contents/MacOS/Selaco
