#!/bin/bash

git_source="git://github.com/steveicarus/iverilog.git"
dependency_tool="git make gcc autoconf bison flex gperf"

echo "Building Ikarus!"

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

if [ -e "./iverilog" ]; then
    echo "Repository already cloned."
else
    echo "Cloning Repository ..."
    git clone ${git_source} > /dev/null 2>&1
fi

# change to projectdir
cd iverilog

if [ -e "configure" ]; then
    echo "Autoconf already done."
else
    echo "genrating configure file ikarus."
    sh autoconf.sh
fi

if [ -e "Makefile" ]; then
    echo "Configuration already done."
else
    echo "Configuring ikarus."
    ./configure
fi

echo "Compile/Recompile sources ..."
if [ -x "$(make -j 4 > /dev/null 2>&1)" ]; then
    echo "Error building ikarus."
else
    echo "Successfully built ikarus."
    echo "Executable location: './iverilog/ivl'"
fi
