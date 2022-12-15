onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate -radix decimal /testbench/addr
add wave -noupdate -radix decimal /testbench/d_in
add wave -noupdate /testbench/wen
add wave -noupdate -radix decimal /testbench/d_out

add wave -noupdate /testbench/empty
add wave -noupdate /testbench/full
add wave -noupdate -radix unsigned /testbench/read
add wave -noupdate -radix unsigned /testbench/rd_clk
add wave -noupdate -radix unsigned /testbench/write
add wave -noupdate -radix unsigned /testbench/wr_clk
add wave -noupdate -radix unsigned /testbench/areset_n
add wave -noupdate -radix decimal /testbench/q

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























