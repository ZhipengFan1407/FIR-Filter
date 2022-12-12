##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog -suppress 12110 +acc -incr ../rtl/dcfifo.v
vlog -suppress 12110 +acc -incr ../rtl/dp_dcram.v

vlog -suppress 12110 +acc -incr test_lfsr.v

# Run Simulator
vsim +acc -t ps -lib work testbench
do waveformat.do
run -all












