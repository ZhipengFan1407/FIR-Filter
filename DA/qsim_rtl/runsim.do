##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../rtl/adder.v
vlog +acc -incr ../rtl/counter.v
vlog +acc -incr ../rtl/dff_en.v
vlog +acc -incr ../rtl/left_shift_1.v
vlog +acc -incr distr_arith.v

# Run Simulator
vsim +acc -t ps -lib work distr_arith
do waveformat.do
run -all















