module MoveSquare(
	input logic reset,
	input logic enable,
	input logic clock,
	input direction_up, // 1 if up 0 if down
	output logic [9:0] upper,
	output logic [9:0] lower
);

always_ff @(posedge clock) begin
	if (reset) begin 
		upper <= 10'd239;
		lower <= 10'd289;
	end
	else if (enable) begin 
		// check if the upper is above pixel 1
		if (direction_up) begin 
			upper <= upper - 2;
			lower <= lower - 2;
		end
		else if (!direction_up) begin 
			upper <= upper + 2;
			lower <= lower + 2;
		end	
	end
end
endmodule