// ============================================================================
// Project Name: Collision Detector
// Author:       Charles Aebi, Sean Dauch
// Description:  Sets the direction for the movement of the box
// ============================================================================

module Collision(
	input logic clock,
	input logic reset,
	input logic [9:0] upper,
	input logic [9:0] lower,
	input logic [9:0] left,
	input logic [9:0] right,
	output logic collision_pulse_vertical, // 1 = move up, 0 = move down
	output logic collision_pulse_horizontal // 1 = move left, 0 = move right
);

always_ff @(posedge clock) begin 

	// default direction is towards bottom right
	if (reset) begin 
		collision_pulse_vertical <= 1'b0; 
		collision_pulse_horizontal <= 1'b0;
	end
	else begin
		
		// vertical collision check
		if (upper <= 40) begin
			collision_pulse_vertical <= 0; // start moving down
		end
		else if (lower >= 512)
			collision_pulse_vertical <= 1; // start moving up
		end
		
		// horizontal collision check
		if (left <= 144) begin
			collision_pulse_horizontal <= 0; // start moving right
		end
		else if (right >= 784) begin
			collision_pulse_horizontal <= 1; // start moving left
		end
		
	end
endmodule
