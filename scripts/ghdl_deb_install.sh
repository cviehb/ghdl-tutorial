#!/bin/bash

echo "Installing GHDL"

gcc_deb_source="http://archive.ubuntu.com/ubuntu/pool/universe/g/ghdl/ghdl-gcc_0.35+git20181129+dfsg-3ubuntu1_amd64.deb"
ghdl_deb_source="http://archive.ubuntu.com/ubuntu/pool/universe/g/ghdl/ghdl_0.35+git20181129+dfsg-3ubuntu1_amd64.deb"
dependency_tool="wget dpkg"
libraries="libgnat-8"

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


# when the file is present we think it is downloaded
if [ -e "ghdl-gcc_0.35+git20181129+dfsg-3ubuntu1_amd64.deb" ]; then
    echo "Looks like gcc is already downloaded"
else
    wget $gcc_deb_source
fi

if [ -e "ghdl_0.35+git20181129+dfsg-3ubuntu1_amd64.deb" ]; then
    echo "Looks like ghdl is already downloaded"
else
    wget $ghdl_deb_source
fi

echo "Try to install GHDL and GHDL-GCC with the apt pkg manager"
sudo dpkg -i ghdl-gcc_0.35+git20181129+dfsg-3ubuntu1_amd64.deb
sudo dpkg -i ghdl_0.35+git20181129+dfsg-3ubuntu1_amd64.deb
