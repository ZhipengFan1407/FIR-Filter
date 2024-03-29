onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate /testbench/empty
add wave -noupdate /testbench/full
add wave -noupdate /testbench/clk2
add wave -noupdate /testbench/clk3
add wave -noupdate -radix unsigned /testbench/read
add wave -noupdate -radix unsigned /testbench/write
# add wave -noupdate -radix unsigned /testbench/areset_n

# add wave -noupdate -radix signed /testbench/x1_bit
# add wave -noupdate -radix signed /testbench/x2_bit
# add wave -noupdate -radix signed /testbench/x3_bit
# add wave -noupdate -radix signed /testbench/x4_bit
# add wave -noupdate -radix signed /testbench/x5_bit
# add wave -noupdate -radix signed /testbench/x6_bit
# add wave -noupdate -radix signed /testbench/x7_bit
# add wave -noupdate -radix signed /testbench/x8_bit

# add wave -noupdate -radix signed /testbench/add6_out
# add wave -noupdate -radix signed /testbench/add7_out
add wave -noupdate -radix signed /testbench/sum
add wave -noupdate -radix signed /testbench/input_data

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 223
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {12 ns}
