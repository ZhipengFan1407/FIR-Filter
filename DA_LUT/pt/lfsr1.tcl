#################################################
# Primetime 
# Script for static timing analysis
# MS 7/2015
#################################################

#################################################
# Units are defined in the .lib file
# time: ns
#################################################

## Global
set sh_enable_page_mode true
set power_enable_analysis true

## Setting files/paths
set verilog_files {../dc/distr_arith.nl.v}
set my_toplevel lfsr1
set search_path ". /courses/ee6321/share/ibm13rflpvt/synopsys/"
set link_path "* scx3_cmos8rf_lpvt_tt_1p2v_25c.db" 

## Read design
read_db "scx3_cmos8rf_lpvt_tt_1p2v_25c.db"
read_verilog $verilog_files
link_design -keep_sub_designs $my_toplevel

## Timing Constraints
source ./timing.tcl


###################################################
## Run STA 
###################################################
set rpt_file "./lfsr1_pt.rpt"
check_timing
report_design >> ${rpt_file}
report_reference >> ${rpt_file}
report_constraint >> ${rpt_file}
report_constraint -all_violators -significant_digits 4 >> ${rpt_file}
report_timing -significant_digits 4 -delay_type min_max >> ${rpt_file}

## Power analysis
set power_analysis_mode "time_based"
read_vcd "../qsim_dc/lfsr1.vcd" -strip_path "testbench/add"
report_switching_activity >> ${rpt_file}
report_switching_activity -list_not_annotated >> ${rpt_file}
update_power
report_power >> ${rpt_file}
report_power -hierarchy  >> ${rpt_file}

write_sdf -context verilog "./lfsr1.sdf"

# Exiting primetime
quit
