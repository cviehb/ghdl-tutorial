#!/bin/bash

echo "Installing GHDL with GCC Backend"

ghdl_source="https://github.com/ghdl/ghdl"
gcc_source="ftp://ftp.gnu.org/gnu/gcc/gcc-8.3.0/gcc-8.3.0.tar.gz"
dependency_tool="wget dpkg make gnat-8"
libraries="libgnat-8 libgmp-dev libmpfr-dev libmpc-dev texinfo zlib1g-dev"

echo "Checking for Dependencies ... "
# check for tool deps
for tool in $dependency_tool; do
    if ! [ -x "$(command -v ${tool})" ]; then
	echo "Error: ${tool} is not installed." >&2
	echo "Try installing it with \"sudo apt install ${tool}\""
	exit 1
    fi
done
echo "Dependencies should be OK."

echo "Checking for Libraries ... "
# check for tool deps
for lib in $libraries; do
    dpkg -s "$lib" >/dev/null 2>&1 && {
        echo "$lib is installed."
    } || {
        echo "$lib is not installed."
	echo "Error: ${lib} is not installed." >&2
	echo "Try installing it with \"sudo apt install ${lib}\""
	exit 1
    }
done
echo "Libraries should be OK."

if [ -e "./ghdl" ]; then
    echo "Repository already cloned."
else
    echo "Cloning Repository ..."
    git clone ${ghdl_source} > /dev/null 2>&1
fi

# start in directory
cd ghdl

# create build dir
if [ -e "build" ]; then
   cd build
else
    mkdir build && cd build
fi       

# check for gcc source
if [ -e "gcc-8.3.0.tar.gz" ]; then
    echo "gcc is already fetched"
else
    wget ${gcc_source}
fi

if [ -e "gcc-8.3.0" ]; then
    echo "gcc is already extracted"
else
    tar -xzf gcc-8.3.0.tar.gz
fi

echo "Doing Config Step for gcc backend integration!"
../configure --with-gcc=./gcc-8.3.0 --prefix=/usr/local
make copy-sources

if [ -e "gcc-objs" ]; then
    cd gcc-objs
else
    mkdir gcc-objs && cd gcc-objs    
fi

echo "Configure GCC!"
../gcc-8.3.0/configure --prefix=/usr/local --enable-languages=c,vhdl \
		       --disable-bootstrap --disable-lto --disable-multilib --disable-libssp \
		       --disable-libgomp --disable-libquadmath

echo "Starting Build/Rebuild of ghdl-gcc backend! Coffee Time ..."
make -j 2 && sudo make install

# change to ghdl dir and build
echo "Starting Build/Rebuild of ghdl lib! Coffee Time ..."
cd ..
make ghdllib && sudo make install
