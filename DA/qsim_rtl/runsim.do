##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog -suppress 12110 +acc -incr ../rtl/distr_arith.v
vlog -suppress 12110 +acc -incr ../rtl/adder.v
vlog -suppress 12110 +acc -incr ../rtl/counter.v
vlog -suppress 12110 +acc -incr ../rtl/dff_en.v
vlog -suppress 12110 +acc -incr ../rtl/left_shift_1.v

vlog -suppress 12110 -incr test_lfsr.v

# Run Simulator
vsim -suppress 12110 -t ps -lib work testbench
do waveformat.do
run -all
