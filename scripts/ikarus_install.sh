#!/bin/bash

echo "Installing Ikarus Verilog"

# when the executabel is build we think it is built
if [ -e "./iverilog/ivl" ]; then
    echo "Looks like iverilog is built."
    cd iverilog && sudo make install
    echo "Sucessfully installed, type 'iverilog' for magic!"
else
    echo "Error Installing iverilog, use build script first!"
fi
