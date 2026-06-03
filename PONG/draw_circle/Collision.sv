module Collision(
	input logic clock,
	input logic reset,
	input logic [9:0] upper,
	input logic [9:0] lower,
	output logic collision_pulse
);

always_ff @(posedge clock) begin 
	if (reset) begin 
		collision_pulse <= 1'b0;
	end
	else if (upper <= 40) 
		collision_pulse <= 0;
	else if (lower >= 512)
		collision_pulse <= 1;
end
endmodule