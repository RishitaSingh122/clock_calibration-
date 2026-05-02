`timescale 1ns/1ps

module clock_calibration_tb;


reg clk_12MHz;
reg pll_clk;
reg start;
reg rstn;


wire done;
wire [31:0] captured_value;


clock_calibration uut (
    .clk_12MHz(clk_12MHz),
    .pll_clk(pll_clk),
    .start(start),
    .rstn(rstn),
    .done(done),
    .captured_value(captured_value)
);


initial begin
    clk_12MHz = 0;
    forever #41.666 clk_12MHz = ~clk_12MHz;  
  
end

initial begin
    pll_clk = 0;
    forever #1.126 pll_clk = ~pll_clk;
    
end


initial begin
    rstn = 0;
    start = 0;

    #100;
    rstn = 1; 

    // Wait for few clocks after reset
    repeat (5) @(posedge clk_12MHz);

    // Generate start pulse synchronized to clk_12MHz
    @(posedge clk_12MHz);
    start <= 1;

    @(posedge clk_12MHz);
    start <= 0;

    // Now FSM will properly detect start = 1 at clk_12MHz rising edge

    wait (done == 1);

    $display("Captured Value = %d", captured_value);

    if (captured_value > 360000 && captured_value < 380000)
        $display("PASS: Captured value within expected range.");
    else
        $display("FAIL: Captured value out of expected range.");

    #500;
    $finish;
end
endmodule

