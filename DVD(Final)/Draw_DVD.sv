// ============================================================================
// Project Name: Draw_DVD
// Author:       Charles Aebi, Sean Dauch, Steven Cao, Alan Nguyen
// Description:  Draws a DVD_logo inside a predefined box
// Sources Used: mifMaker, Lab 7 document
// ============================================================================

module Draw_DVD(
	input logic [9:0] h_counter,
	input logic [9:0] v_counter,
	input logic reset,
	input logic clock,
	input logic [9:0] upper,
	input logic [9:0] lower,
	input logic [9:0] left,
	input logic [9:0] right,
	output logic [3:0] color
);

logic [14:0] mif_address;
logic [15:0] mif_color;

// where the mif file is stored
ROM dvd_logo(
	.address (mif_address),
	.clock(clock),
	.q(mif_color)
);

always_ff @(posedge clock) begin 

	// on reset draw black to the entire screen
	if (reset) begin 
		color = 4'b0000;
		mif_address = 15'b0;
	end

	// only prints dvd if inside the box
	else if ((h_counter >= left && h_counter <= right) && (v_counter >= upper && v_counter <= lower)) begin

		// print white when dvd is not black
		if(mif_color > 16'b0)begin
			color = 4'b1111;
			
		end else begin
			color = 4'b0;
		
		end

		// little algorithm to find the mif address based on location in the box
		mif_address <= (h_counter-left)+ (256*(v_counter-upper));
		
	end 
	else begin 
		color = 4'b0000;
	end
end

endmodule
