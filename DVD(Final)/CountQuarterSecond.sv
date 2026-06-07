// ============================================================================
// Project Name: CountQuarterSecond
// Author:       Charles Aebi
// Description:  When a collision occurs, this module sends an enable signal to the
// clock divivder responsible for sound (we reduced this to 1/10th of a second after physical testing)
// ============================================================================
module CountQuarterSecond(
	input logic clock50,
	input logic reset,
	input logic collision_has_changed,
	output logic freq_enable
);

logic [25:0] counter;
logic run_clock;

always_ff @(posedge clock50) begin 
	// RESET
	if (reset) begin 
		counter <= 26'd0;
		freq_enable <= 1'b0;
		run_clock <= 1'b0;
	end
	if (collision_has_changed) begin 
		run_clock <= 1'b1;
	end
	if (run_clock && counter < 5_000_000) begin
		freq_enable <= 1'b1;
		counter <= counter + 26'd1;
	end
	else if (run_clock && counter >= 5_000_000) begin 
		freq_enable <= 1'b0;
		run_clock <= 1'b0;
		counter <= 26'd0;
	end
end

endmodule