module clock_calibration(
	input             clk_12MHz,
	input             pll_clk,
	input             start,
	input             rstn,
	output reg        done,
	output reg [31:0] captured_value );

localparam START = 2'b00;
localparam RUN = 2'b01;
localparam STOP = 2'b10;
localparam CAPTURE = 2'b11;

reg [1:0] current_state, next_state;
reg temp;
reg temp_sync1, temp_sync2;
localparam fixed_val = 32'd100;

 reg [31:0] count_12MHz;

always @(posedge clk_12MHz or negedge rstn) begin 
	if (!rstn)
		current_state <= START;
	else 
		current_state <= next_state;
end


always @(*) begin 
	case (current_state) 

		START: if (start) 
	                 next_state <= RUN;
	               else next_state <= START;

                RUN: if (count_12MHz == fixed_val)
                          next_state = STOP;
                     else
                           next_state = RUN;

		STOP: next_state = CAPTURE;

		CAPTURE: next_state = START;

		default : next_state = START;

	endcase
end


always @(posedge clk_12MHz or negedge rstn) begin
	if (!rstn) begin
		temp <= 0;
		done <= 0;
	end
	else case (current_state) 
		START: begin 
		       temp <= 0;
	               done <= 0;
	       end

	       RUN: begin temp <= 1;
	                  done <= 0;
		  end

		STOP: begin temp <= 0;
		            done <= 1;
		    end
		CAPTURE: begin 
		            temp <= 0;
			    done <= 0;
		    end

		    default: begin 
		            temp <= 0;
			    done <= 0;
		    end
	    endcase
    end
  


   
    always @(posedge clk_12MHz or negedge rstn) begin
	    if(!rstn)
		    count_12MHz <= 0;
	    else if (current_state == START)
		    count_12MHz <= 0;
	    else if (temp) begin
		    if (count_12MHz <= fixed_val)
			    count_12MHz <= count_12MHz + 1;
	    end
	    else count_12MHz <= count_12MHz; 
	    //else count_12MHz <= 0; 

    end





    always @(posedge pll_clk or posedge rstn) begin
	    if (!rstn) begin
		    temp_sync1 <= 0;
		    temp_sync2 <= 0;

	    end else begin 
		    temp_sync1 <= temp;
		    temp_sync2 <= temp_sync1;

	    end
    end



reg [31:0] count_pll;

   always @(posedge pll_clk or negedge rstn) begin
	   if(!rstn)
		   count_pll <= 0;
	   else if (current_state == START)
		   count_pll <= 0;
	   else if (temp_sync2)
		   count_pll <= count_pll + 1;
	   else count_pll <= count_pll;

   end





always @(posedge clk_12MHz or negedge rstn) begin
    if (!rstn)
        captured_value <= 0;
    else if (current_state == CAPTURE)
        captured_value <= count_pll;
end




endmodule

