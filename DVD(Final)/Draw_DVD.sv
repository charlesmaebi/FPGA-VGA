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

ROM dvd_logo(
	.address (mif_address),
	.clock(clock),
	.q(mif_color)
);

always_ff @(posedge clock) begin 

	if (reset) begin 
		color = 4'b0000;
		mif_address = 15'b0;
	end
	else if ((h_counter >= left && h_counter <= right) && (v_counter >= upper && v_counter <= lower)) begin

		// print white when dvd is not black
		if(mif_color > 16'b0)begin
			color = 4'b1111;
			
		end else begin
			color = 4'b0;
		
		end
			
		mif_address <= (h_counter-left)+ (256*(v_counter-upper));
		
	end 
	else begin 
		color = 4'b0000;
	end
end

endmodule