module MoveSquare(
	input logic reset,
	input logic enable,
	input logic clock,
	output logic [9:0] vertical
);

always_ff @(posedge clock) begin
	if (reset) begin 
		vertical <= 10'd263;
	end
	else if (enable) begin 
		vertical <= vertical - 10;
	end
end
endmodule