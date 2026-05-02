Clock Calibration Module (Verilog)
Overview


The clock_calibration module is a dual-clock domain design used to measure and compare the frequency of a PLL clock (pll_clk) against a reference clock (clk_12MHz).
It works by:
	Generating a fixed time window using the 12 MHz reference clock 
	Counting how many pll_clk cycles occur during that window 
	Capturing the result for calibration or frequency estimation 
________________________________________
Features

	Dual clock domain operation (clk_12MHz and pll_clk) 
	FSM-controlled measurement cycle 
	Synchronization across clock domains (2-flop synchronizer) 
	Configurable measurement window (fixed_val) 
	Captured PLL count output for frequency comparison 
________________________________________
Working Principle


	START State 
	Waits for start signal 
	Resets counters 
	RUN State 
	Enables counting window (temp = 1) 
	Counts clk_12MHz cycles up to fixed_val 
	STOP State 
	Disables counting 
	Signals completion (done = 1) 
	CAPTURE State 
	Captures the number of pll_clk cycles counted 
	Stores in captured_value 
________________________________________
FSM State Diagram


START → RUN → STOP → CAPTURE → START
________________________________________
 Module Interface

 
module clock_calibration(
    input             clk_12MHz,      // Reference clock
    input             pll_clk,        // PLL clock to measure
    input             start,          // Start signal
    input             rstn,           // Active-low reset
    output reg        done,           // Indicates completion
    output reg [31:0] captured_value  // Measured PLL cycles
);
________________________________________
 How It Works

 
	A fixed number of reference clock cycles (fixed_val = 100) defines the measurement window. 
	During this window: 
	count_12MHz counts reference clock cycles 
	count_pll counts PLL clock cycles 
	After the window: 
	count_pll is captured into captured_value 
________________________________________
 Clock Domain Crossing (CDC)

 
	Signal temp is generated in the clk_12MHz domain 
	It is synchronized into the pll_clk domain using: 
	temp_sync1 
	temp_sync2 
This prevents metastability issues.
________________________________________
Frequency Estimation


You can estimate PLL frequency using:
f_pll="captured_value" /"fixed_val" ×f_ref

Where:
	f_ref = 12 MHz 
	fixed_val = 100 
________________________________________
 Parameters

 
Parameter	Value	Description
fixed_val	100	Measurement window (in clk_12MHz cycles)
________________________________________
 Internal Signals

 
Signal	Description
temp	Enables counting window
count_12MHz	Reference clock counter
count_pll	PLL clock counter
temp_sync1/2	CDC synchronizers
current_state	FSM state
________________________________________
 Notes / Considerations

 
	Ensure pll_clk is stable before starting measurement 
	CDC is handled for control signal (temp), but not for multi-bit signals 
	Reset is active-low (rstn) 
	Measurement resolution depends on fixed_val 
________________________________________
Possible Improvements


	Make fixed_val programmable 
	Add averaging over multiple measurements 
	Add overflow protection for counters 
	Use Gray coding or handshake for more robust CDC (if extended) 
________________________________________
 Use Cases

 
	PLL frequency verification 
	Clock monitoring systems 
	FPGA-based calibration units 
	Digital frequency measurement

