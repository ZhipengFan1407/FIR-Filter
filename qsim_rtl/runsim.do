##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../rtl/distr_arith.v
vlog +acc -incr ../rtl/adder.v
vlog +acc -incr ../rtl/adder_reg.v
vlog +acc -incr ../rtl/counter.v
vlog +acc -incr ../rtl/dff_en.v
vlog +acc -incr ../rtl/left_shift_1.v
vlog +acc -incr ../rtl/lut0.v
vlog +acc -incr ../rtl/lut1.v
vlog +acc -incr ../rtl/lut2.v
vlog +acc -incr ../rtl/lut3.v
vlog +acc -incr ../rtl/lut4.v
vlog +acc -incr ../rtl/lut5.v
vlog +acc -incr ../rtl/lut6.v
vlog +acc -incr ../rtl/lut7.v
vlog +acc -incr test_da.v

# Run Simulator
vsim -t ps -lib work test_da
do waveformat.do
run -all
