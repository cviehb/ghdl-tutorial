#!/bin/bash

ghdl_source="https://github.com/ghdl/ghdl"
dependency_tool="git make gcc gnat"

echo "Building GHDL!"

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

if [ -e "./ghdl" ]; then
    echo "Repository already cloned."
else
    echo "Cloning Repository ..."
    git clone ${ghdl_source} > /dev/null 2>&1
fi

# change to projectdir
cd ghdl

if [ -e "Makefile" ]; then
    echo "Configuration already done."
else
    echo "Configuring ghdl."
    ./configure --prefix=/usr/local
fi

echo "Compile/Recompile sources ..."
if [ -x "$(make -j 4 > /dev/null 2>&1)" ]; then
    echo "Error building ghdl."
else
    echo "Successfully built ghdl."
    echo "Executable location: './ghdl/ghdl_mcode'"
fi
