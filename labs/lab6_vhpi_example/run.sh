#!/bin/bash 

ghdl -i *.vhd
ghdl -a *.vhd
ghdl -e -Wl,-lm tb_math
ghdl -r tb_math --vcd=tb_math.vcd

