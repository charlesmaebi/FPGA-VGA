module Clock(
	input logic clock,
	input logic reset,
	output logic pulse_clock
);

logic [25:0] clk_count;

always_ff @(posedge clock or posedge reset) begin 

	if (reset) begin 
		clk_count <= 26'd0;
		pulse_clock <= 1'b0;
	end 
	else begin 
		pulse_clock <= 1'b0;
		if (clk_count == 26'd500_000) begin 
			clk_count <= 26'd0;
			pulse_clock <= 1'b1;
		end
		else begin 
			clk_count <= clk_count + 1;
		end
	end
end
endmodule