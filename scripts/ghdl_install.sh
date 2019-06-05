#!/bin/bash

echo "Installing GHDL"

# when the executabel is build we think it is built
if [ -e "./ghdl/ghdl_mcode" ]; then
    echo "Looks like ghdl is built."
    cd ghdl && sudo make install
    echo "Sucessfully installed, type 'ghdl' for magic!"
else
    echo "Error Installing ghdl, use build script first!"
fi
