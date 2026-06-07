// ============================================================================
// Project Name: ClockDividerSound
// Author:       Charles Aebi, Sean Dauch, Steven Cao, Alan Nguyen
// Description:  Drivers speaker with a 3.5KHz clock signal when enabled
// ============================================================================
module ClockDividerSound(
	input logic clock50,
	input logic reset,
	input logic enable,
	output logic clock_signal
);

logic [25:0] counter;

// Here, we want to emulate a 3.5KHz clock signal with a 50MHz clock
// We ensure the noise is audible by keeping the output
// high for half of the signal instead of a pulse of the 50MHz
always_ff @(posedge clock50 or posedge reset) begin
	if (reset) begin 
		counter <= 26'd0;
		clock_signal <= 1'b0;
	end
	else if (!enable) begin 
		counter <= 26'd0;
		clock_signal <= 1'b0;
	end
	else if (counter == 26'd14_284) begin // 50,000,00 / 3,500 is approx 14,284 cyc;es
		counter <= 26'd0;
		clock_signal <= 1'b1;
	end
	else if (counter == 26'd7_142) begin  // Only keep the signal high for half of the 3.5KHz cycle
		counter <= counter + 26'd1;
		clock_signal <= 1'b0;
	end
	else begin 
		counter <= counter + 26'd1;
	end
end

endmodule