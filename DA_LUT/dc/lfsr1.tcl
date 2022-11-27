#########################################
# TCL script for Design Compiler        #
# MS 2015                               #
#########################################

#########################################
# READ Design and Library               #
#########################################
set top_level distr_arith
source -verbose "../common_script/common.tcl"
read_verilog {../rtl/distr_arith.v}
read_verilog {../rtl/lut0.v}
read_verilog {../rtl/lut1.v}
read_verilog {../rtl/lut2.v}
read_verilog {../rtl/lut3.v}
read_verilog {../rtl/lut4.v}
read_verilog {../rtl/lut5.v}
read_verilog {../rtl/lut6.v}
read_verilog {../rtl/lut7.v}

read_verilog {../rtl/dff_en.v}
read_verilog {../rtl/adder.v}
read_verilog {../rtl/adder_reg.v}
read_verilog {../rtl/left_shift_1.v}
read_verilog {../rtl/counter.v}

set set_fix_multiple_port_nets "true"
list_designs

if { [check_error -v] == 1 } { exit 1 }

#########################################
# Design Constraints                    #
#########################################
current_design $top_level
link
check_design
source -verbose "./timing.tcl"
set_max_capacitance 0.005 [all_inputs]
set_max_fanout 4 $top_level
set_max_fanout 4 [all_inputs]
set_max_area 0 
set_fix_multiple_port_nets -all -buffer_constants

#########################################
# Compile                               #
#########################################
check_design
#uniquify
current_design $top_level
link
compile_ultra

#########################################
# Optimize design                       #
# Some pointers for possible optimizatio# 
# Check the DC reference manual         #
#########################################
#set_transform_for_retiming {temp_reg[6] temp_reg[5] temp_reg[4] temp_reg[3] temp_reg[2] temp_reg[1] temp_reg[0]} dont_retime
#optimize_registers -clock clk -edge rise -justification_effort high 
#balance_registers
#source -verbose "../script/timing.1.2ns.tcl"
#pipeline_design -stages 8 -clock_port_name $clk_name -check_design -verbose -print_critical_loop
#set_max_capacitance 1 [all_inputs] 
#compile_ultra -no_autoungroup -no_boundary_optimization
#remove_clock -all
#pipeline_design -stages 8 -clock_port_name $clk_name -async_reset reset -check_design -verbose -minimum_period_only

#########################################
# Write outputs                         #
#########################################
source -verbose "../common_script/namingrules.tcl"
set verilogout_no_tri TRUE
write -hierarchy -format verilog -output "${top_level}.nl.v"
#write_sdf -context verilog "${top_level}.temp.sdf"
write_sdc "${top_level}.syn.sdc" -version 1.7
write_sdf "${top_level}.syn.sdf"
# Generate report file
set maxpaths 20
set rpt_file "${top_level}.dc.rpt"
check_design > $rpt_file
report_area  >> ${rpt_file}
report_power -hier -analysis_effort medium >> ${rpt_file}
report_design >> ${rpt_file}
report_cell >> ${rpt_file}
report_port -verbose >> ${rpt_file}
report_compile_options >> ${rpt_file}
report_constraint -all_violators -verbose >> ${rpt_file}
report_timing -path full -delay max -max_paths $maxpaths -nworst 100 >> ${rpt_file}
report_timing -delay max -nworst 1 -max_paths 10000 -path end -nosplit -unique -sort_by slack > ${top_level}.syn.critical_regs
report_timing -delay max -nworst 1 -max_paths 10000 -path full -nosplit -unique -sort_by slack > ${top_level}.syn.critical_regs.full
report_timing -delay max -nworst 1 -max_paths 10000 -path end -nosplit -unique -sort_by slack -to [all_outputs] > ${top_level}.syn.critical_regs.output
report_timing -delay max -nworst 1 -max_paths 10000 -path end -nosplit -unique -sort_by slack -to [all_registers -data_pins] > ${top_level}.syn.critical_regs.regs
report_timing -delay min -nworst 1 -max_paths 10000 -path short -nosplit -unique -sort_by slack > ${top_level}.syn.fast_path
quit
