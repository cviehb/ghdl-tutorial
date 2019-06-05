#!/bin/bash

ghdl -a tb_full_adder.vhd
ghdl -e full_adder_test
ghdl -r full_adder_test --wave=full_adder_test.ghw
