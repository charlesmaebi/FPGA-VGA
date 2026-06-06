// ============================================================================
// Project Name: Color Decoder
// Author:       Charles Aebi
// Description:  This module will take in a 2 bit color value and convert it to four bit
// Sources Used: Lab 6 Document
// ============================================================================


module Decoder(
	input logic [1:0] color_in,
	output logic [3:0] color_out
);

always_comb begin 
	case (color_in)
		2'b00: color_out = 4'b0000;
		2'b01: color_out = 4'b0101;
		2'b10: color_out = 4'b1010;
		2'b11: color_out = 4'b1111;
	endcase
end	
	
endmodule
