#!/bin/bash

iverilog -o full_adder_test full_adder.v full_adder_test.v
vvp full_adder_test
