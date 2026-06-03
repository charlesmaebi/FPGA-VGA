module MoveSquare(
	input logic reset,
	input logic clock,
	output logic [9:0] vertical
);

initial begin 
	vertical = 10'd263;
end

logic enable;

Clock dut(
	.reset(reset),
	.clock(clock),
	.pulse_clock(enable)
);

always_ff @(posedge enable) begin
	vertical <= vertical - 10;
end
endmodule