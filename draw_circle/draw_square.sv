// 440-450 H
// 258-268 V
module DrawSquare(
	input logic [9:0] h_counter,
	input logic [9:0] v_counter,
	input logic reset,
	input logic [9:0] y_coordinate,
	output logic [3:0] color
);

always_comb begin 
	if (reset) begin 
		color = 4'b0000;
	end
	else if ((h_counter >= 440 && h_counter <= 450) && (v_counter >= y_coordinate - 4 && v_counter <= y_coordinate + 4)) begin 
		color = 4'b1111;
	end 
	else begin 
		color = 4'b0000;
	end
end

endmodule