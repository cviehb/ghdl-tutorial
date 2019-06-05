#!/bin/bash

tool="iverilog"
echo "Try converting a Verilog Source to VHDL Source"

# check if converter is present
if ! [ -x "$(command -v ${tool})" ]; then
    echo "Error: ${tool} is not installed." >&2
    exit 1
fi

# check if file exists and correct file extension
if [ -e $1 && $1 == "*.v" ]]; then
    echo "Conversion ..."
    iverilog -t vhdl -o ${1%.*}.vhd $1
    echo "Sucessfully installed, type 'iverilog' for magic!"
else
    echo "Error cannot locate file or false extension: ${1}!"
fi
