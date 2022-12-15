
##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../rtl/mem16kb.v
vlog +acc -incr ../rtl/dec_4to16.v
vlog +acc -incr ../rtl/mem256w16b.v
vlog +acc -incr test_lfsr.v

# Run Simulator
vsim -t ps -lib work testbench
do waveformat.do
run -all






















