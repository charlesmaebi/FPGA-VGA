// ============================================================================
// Project Name: MoveSquare
// Author:       Charles Aebi, Sean Dauch
// Description:  Provide physics for the movement of the box
// ============================================================================
module MoveSquare#(
	parameter SPEEDBITS = 5
)(
	input logic reset,
	input logic enable,
	input logic clock,
	input logic [SPEEDBITS-1:0] speed_y,
	input logic direction_up, // 1 if up 0 if down
	output logic [9:0] upper,
	output logic [9:0] lower,
	
	input logic [SPEEDBITS-1:0] speed_x,
	input logic direction_left, // 1 if left 0 if right
	output logic [9:0] left,
	output logic [9:0] right
);

always_ff @(posedge clock) begin

	// initial position for the box
	if (reset) begin 
		upper <= 10'd239;
		lower <= 10'd358;
		left <= 10'd423;
		right <= 10'd679;
	end
	else if (enable) begin 

		if (direction_up) begin // move box up
			upper <= upper - speed_y;
			lower <= lower - speed_y;
		end
		else if (!direction_up) begin // move box down
			upper <= upper + speed_y;
			lower <= lower + speed_y;
		end
	
		if (direction_left) begin // move box left
			left <= left - speed_x;
			right <= right - speed_x;
		end
		else if (!direction_left) begin // move box right
			left <= left + speed_x;
			right <= right + speed_x;
		end
			
	end
end
endmodule
