module Collision(
	input logic clock,
	input logic reset,
	input logic [9:0] upper,
	input logic [9:0] lower,
	input logic [9:0] left,
	input logic [9:0] right,
	output logic collision_pulse_vertical,
	output logic collision_pulse_horizontal
);

always_ff @(posedge clock) begin 
	if (reset) begin 
		collision_pulse_vertical <= 1'b0;
		collision_pulse_horizontal <= 1'b0;
	end
	else begin
		
		// vertical collision check
		if (upper <= 40) begin
			collision_pulse_vertical <= 0;
		end
		else if (lower >= 512)
			collision_pulse_vertical <= 1;
		end
		
		// horizontal collision check
		if (left <= 144) begin
			collision_pulse_horizontal <= 0;
		end
		else if (right >= 784) begin
			collision_pulse_horizontal <= 1;
		end
		
	end
endmodule