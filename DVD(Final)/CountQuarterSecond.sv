module CountQuarterSecond(
	input logic clock50,
	input logic reset,
	input logic collision_has_changed,
	output logic freq_enable
);

logic [25:0] counter;
logic run_clock;

always_ff @(posedge clock50) begin 

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