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
	output logic [3:0] green_display, // 0000 off 1111 on
	output logic sound_signal
);

wire clock25; // changed name for clarity 
wire enable_movement;// changed name for clarity 
wire [3:0] red_decoded, green_decoded, blue_decoded;
wire [9:0] h_counter, v_counter;
wire [3:0] color;
wire [9:0] upper, lower, left, right;
wire collision_pulse_vertical, collision_pulse_horizontal;
wire collision_has_changed, freq_enable; //sound wires

ClockDivider clock_divider(
	.clock50(clock50),
	.reset(reset),
	.clock25(clock25)
);

Clock clock(
	.clock(clock50),
	.reset(reset),
	.pulse_clock(enable_movement)
);

SyncCount sync_count(
	.enable(clock25),
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
	.left(left),
	.right(right),
	.collision_pulse_vertical(collision_pulse_vertical), // 1 is up
	.collision_pulse_horizontal(collision_pulse_horizontal) // 1 is left
	
);

MoveSquare #(
	.SPEEDBITS(2)

)move_square(
	.reset(reset),
	.enable(enable_movement),
	.clock(clock50),
	.speed_y(3),
	.direction_up(collision_pulse_vertical),
	.upper(upper),
	.lower(lower),
	
	.speed_x(3),
	.direction_left(collision_pulse_horizontal),
	.left(left),
	.right(right)
);

// SOUND


CollisionHasChanged coll_change(
	.clock50(clock50),
	.reset(reset),
	.collision_h(collision_pulse_horizontal),
	.collision_v(collision_pulse_vertical),
	.collision_has_changed(collision_has_changed)
);

CountQuarterSecond quart_sec(
	.clock50(clock50),
	.reset(reset),
	.collision_has_changed(collision_has_changed),
	.freq_enable(freq_enable)
);

ClockDividerSound clock_sound(
	.clock50(clock50),
	.reset(reset),
	.enable(freq_enable),
	.clock_signal(sound_signal)
);

DrawSquare ball(
	.h_counter(h_counter),
	.v_counter(v_counter),
	.reset(reset),
	.upper(upper),
	.lower(lower),
	.left(left),
	.right(right),
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