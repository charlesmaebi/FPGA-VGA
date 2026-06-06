// ============================================================================
// Project Name: Clock Divider
// Author:       Charles Aebi
// Description:  A clock divider module that takes a high-frequency (50 MHz) 
//               input clock and generates and clock at 1/2 the frequency (25MHz).
// ============================================================================

module ClockDivider(
	input logic clock50,
	input logic reset,
	output logic clock25
);
	logic toggle;
    
always_ff @(posedge clock50 or posedge reset) begin
	if (reset)
		toggle <= 1'b0;
	else
		toggle <= !toggle;
end
    
assign clock25 = toggle; // should toggle at 25 MHz
endmodule
