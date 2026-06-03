module ClockDividerSound(
	input logic clock50,
	input logic reset,
	input logic enable,
	output logic clock_signal
);

logic [25:0] counter;

always_ff @(posedge clock50 or posedge reset) begin
	if (reset) begin 
		counter <= 26'd0;
		clock_signal <= 1'b0;
	end
	else if (!enable) begin 
		counter <= 26'd0;
		clock_signal <= 1'b0;
	end
	else if (counter == 26'd14_284) begin 
		counter <= 26'd0;
		clock_signal <= 1'b1;
	end
	else if (counter == 26'd7_142) begin 
		counter <= counter + 26'd1;
		clock_signal <= 1'b0;
	end
	else begin 
		counter <= counter + 26'd1;
	end
end

endmodule