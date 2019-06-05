#!/bin/bash

ghdl -a math-p.vhd
ghdl -a tb_math.vhd
ghdl --bind tb_math
gcc -o call_from_c call_from_c.c -lm -Wl,`ghdl --list-link tb_math`
