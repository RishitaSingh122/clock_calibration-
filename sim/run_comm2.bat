vlib work
vlog -f ..\tb\filelist.lst -sv -lint
#vsim -debugDB clock_calibration_tb -novopt -c
vsim -debugDB clock_calibration_tb -do wave.do  
