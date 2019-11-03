#!/bin/sh

vlib work
vlog *.v

vsim -c testbench_main -do "    run;    exit"

