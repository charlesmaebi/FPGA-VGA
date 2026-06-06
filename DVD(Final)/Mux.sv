// ============================================================================
// Project Name: Mux
// Author:       Charles Aebi
// Description:  Only displays color when hsync and vsync are high
// Sources Used: Lab 6 document
// ============================================================================
module Mux(
	input logic vsync,
	input logic hsync,
	input logic [3:0] color,
	output logic [3:0] display
);

always_comb begin 
	if (vsync && hsync) begin 
		display = color;
	end
	else begin 
		display = 4'b0000;
	end
end

endmodule
