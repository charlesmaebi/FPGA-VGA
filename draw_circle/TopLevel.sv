/*
Basic implementation:
Two switches control the 
color display, either red, blue, green, or blank - 2bit
*/
module TopLevel(
	input logic clock50,
	input logic reset,
	output logic hsync,
	output logic vsync,
	output logic [3:0] red_display, // 0000 off 1111 on
	output logic [3:0] blue_display, // 0000 off 1111 on
	output logic [3:0] green_display // 0000 off 1111 on
);

wire enable_n;
wire enable;
wire [3:0] red_decoded, green_decoded, blue_decoded;
wire [9:0] h_counter, v_counter;
wire [3:0] color;
wire [9:0] upper, lower;
wire collision_pulse;

ClockDivider clock_divider(
	.clock50(clock50),
	.reset(reset),
	.enable_n(enable_n)
);

Clock clock(
	.clock(clock50),
	.reset(reset),
	.pulse_clock(enable)
);

SyncCount sync_count(
	.enable_n(enable_n),
	.reset(reset),
	.hsync(hsync),
	.vsync(vsync),
	.h_counter(h_counter),
	.v_counter(v_counter)
);

Collision collision(
	.clock(clock50),
	.reset(reset),
	.upper(upper),
	.lower(lower),
	.collision_pulse(collision_pulse)
);

MoveSquare move_square(
	.reset(reset),
	.enable(enable),
	.clock(clock50),
	.direction_up(collision_pulse),
	.upper(upper),
	.lower(lower)
);


DrawSquare ball(
	.h_counter(h_counter),
	.v_counter(v_counter),
	.reset(reset),
	.upper(upper),
	.lower(lower),
	.color(color)
);

Mux red_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(color),
	.display(red_display)
);

Mux green_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(color),
	.display(green_display)
);


Mux blue_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(color),
	.display(blue_display)
);

endmodule