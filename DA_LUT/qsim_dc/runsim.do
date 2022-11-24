##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

#Setup
 vlib work
 vmap work work

#Include Netlist and Testbench
 vlog +acc -incr ../dc/ibm13rflpvt.v
 vlog +acc -incr ../dc/distr_arith.nl.v

vlog -suppress 12110 +acc -incr ../rtl/distr_arith.v
vlog -suppress 12110 +acc -incr ../rtl/adder.v
vlog -suppress 12110 +acc -incr ../rtl/counter.v
vlog -suppress 12110 +acc -incr ../rtl/dff_en.v
vlog -suppress 12110 +acc -incr ../rtl/left_shift_1.v

vlog -suppress 12110 +acc -incr ../rtl/lut0.v
vlog -suppress 12110 +acc -incr ../rtl/lut1.v
vlog -suppress 12110 +acc -incr ../rtl/lut2.v
vlog -suppress 12110 +acc -incr ../rtl/lut3.v
vlog -suppress 12110 +acc -incr ../rtl/lut4.v
vlog -suppress 12110 +acc -incr ../rtl/lut5.v
vlog -suppress 12110 +acc -incr ../rtl/lut6.v
vlog -suppress 12110 +acc -incr ../rtl/lut7.v

vlog -suppress 12110 -incr test_lfsr.v


Run Simulator
#SDF from DC is annotated for the timing check
vsim -voptargs=+acc -t ps -lib work -sdftyp add=../dc/distr_arith.syn.sdf testbench
 do waveformat.do
 run -all


























