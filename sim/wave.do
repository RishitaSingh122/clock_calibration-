onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /clock_calibration_tb/clk_12MHz
add wave -noupdate /clock_calibration_tb/pll_clk
add wave -noupdate /clock_calibration_tb/start
add wave -noupdate /clock_calibration_tb/rstn
add wave -noupdate /clock_calibration_tb/done
add wave -noupdate /clock_calibration_tb/captured_value
add wave -noupdate /clock_calibration_tb/uut/clk_12MHz
add wave -noupdate /clock_calibration_tb/uut/pll_clk
add wave -noupdate /clock_calibration_tb/uut/start
add wave -noupdate /clock_calibration_tb/uut/rstn
add wave -noupdate /clock_calibration_tb/uut/done
add wave -noupdate /clock_calibration_tb/uut/captured_value
add wave -noupdate /clock_calibration_tb/uut/current_state
add wave -noupdate /clock_calibration_tb/uut/next_state
add wave -noupdate /clock_calibration_tb/uut/temp
add wave -noupdate /clock_calibration_tb/uut/temp_sync1
add wave -noupdate /clock_calibration_tb/uut/temp_sync2
add wave -noupdate /clock_calibration_tb/uut/count_12MHz
add wave -noupdate /clock_calibration_tb/uut/count_pll
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9396470 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 242
configure wave -valuecolwidth 132
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {10193595 ps}
