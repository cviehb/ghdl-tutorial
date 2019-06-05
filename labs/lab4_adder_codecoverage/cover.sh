#!/bin/bash

ghdl -a  -Wc,-fprofile-arcs -Wc,-ftest-coverage adder.vhd
ghdl -a  tb_adder.vhd
ghdl -e -Wl,-lgcov adder_tb
ghdl -r adder_tb
gcov -s $PWD adder.vhd
lcov -c -d . -o adder_tb.info
genhtml adder_tb.info
