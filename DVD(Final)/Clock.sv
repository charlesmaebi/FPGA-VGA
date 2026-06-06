// ============================================================================
// Project Name: 20ms Clock
// Author:       Charles Aebi
// Description:  A clock divider module that takes a high-frequency (50 MHz) 
//               input clock and generates a single-cycle high pulse exactly 
//               every 20 milliseconds (50 Hz frequency).
// ============================================================================

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

		// pulse_clock is 0 by default
		pulse_clock <= 1'b0;

		// Once the counter reaches the miles stone
		// reset counter and send pulse_clock
		if (clk_count == 26'd1_000_000) begin 
			clk_count <= 26'd0;
			pulse_clock <= 1'b1;
		end
		else begin 

			// Add one every clock cycle
			clk_count <= clk_count + 1;
		end
	end
end
endmodule
