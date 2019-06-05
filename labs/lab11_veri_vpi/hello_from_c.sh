#!/bin/bash 

iverilog-vpi hello.c
iverilog -o hello.vvp hello.v
vvp -M. -m hello hello.vvp
