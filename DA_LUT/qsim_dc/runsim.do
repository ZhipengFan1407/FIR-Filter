##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog +acc -incr /courses/ee6321/share/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog +acc -incr ../dc/distr_arith.nl.v
vlog +acc -incr test_da.v

# Run Simulator
#SDF from DC is annotated for the timing check

vsim -voptargs=+acc -t ps -lib work -sdftyp da0=../dc/distr_arith.syn.sdf test_da
do waveformat.do
run -all

















