onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_da/clk3
add wave -noupdate /test_da/reset
add wave -noupdate /test_da/count_reach
add wave -noupdate -radix signed /test_da/x1_bit
add wave -noupdate -radix signed /test_da/x2_bit
add wave -noupdate -radix signed /test_da/x3_bit
add wave -noupdate -radix signed /test_da/x4_bit
add wave -noupdate -radix signed /test_da/x5_bit
add wave -noupdate -radix signed /test_da/x6_bit
add wave -noupdate -radix signed /test_da/x7_bit
add wave -noupdate -radix signed /test_da/x8_bit
add wave -noupdate -radix signed /test_da/dff0_out
add wave -noupdate -radix signed /test_da/add6_out
add wave -noupdate -radix signed /test_da/add7_out
add wave -noupdate -radix signed /test_da/leftshift_out
add wave -noupdate -radix signed /test_da/sum


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
WaveRestoreZoom {0 ns} {10 ns}

