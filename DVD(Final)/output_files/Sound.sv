module Sound(
	input logic clock50,
	input logic collision_h,
	input logic collision_v,
	input logic clock3p5khz,
	output logic sound_signal
);

logic collision_h_past;
logic collision_v_past;
logic start_counter;

logic [25:0] counter;

initial begin 
	counter = 1'b0;
end

always_ff @(posedge clock50) begin 
	
	if ((collision_h_past != collision_h || collision_v_past != collision_v) && counter < 5_000_000) begin 
		start_counter <= 1'b1;
		collision_h_past <= collision_h;
		collision_v_past <= collision_v;
		
	end
	else if (counter < 5_000_000) begin
		start_counter <= 1'b1;
		collision_h_past <= collision_h;
		collision_v_past <= collision_v;
	end
	else begin 
		start_counter <= 1'b0;
		collision_h_past <= collision_h;
		collision_v_past <= collision_v;
	end
	
end

always_ff @(posedge clock50) begin 
	if (start_counter) begin 
		counter <= counter + 26'd1;
	end
	else begin 
		counter <= 26'd0;
	end
end

endmodule
	

