# clock_calibration-
The clock_calibration module measures the frequency of a PLL clock (pll_clk) by counting how many of its cycles occur within a fixed time window defined using a 12 MHz reference clock. It uses an FSM and proper clock-domain synchronization to capture this count (captured_value), enabling estimation of the PLL frequency relative to the reference.
