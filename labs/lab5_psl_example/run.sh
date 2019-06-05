#!/bin/bash

ghdl -a -fpsl tb_psl_assertions.vhd
ghdl -e -fpsl tb_bus_arbiter
ghdl -r tb_bus_arbiter --stop-time=10us --psl-report=psl_rep.json
