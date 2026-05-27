/*
Basic implementation:
Two switches control the 
color display, either red, blue, green, or blank - 2bit
*/
module VgaDriver(
	input logic clock50,
	input logic reset,
	input logic [1:0] red,
	input logic [1:0] blue,
	input logic [1:0] green,
	output logic hsync,
	output logic vsync,
	output logic [3:0] red_display, // 0000 off 1111 on
	output logic [3:0] blue_display, // 0000 off 1111 on
	output logic [3:0] green_display // 0000 off 1111 on
);

wire enable_n;
wire [3:0] red_decoded, green_decoded, blue_decoded;

ClockDivider clock_divider(
	.clock50(clock50),
	.reset(reset),
	.enable_n(enable_n)
);

SyncCount sync_count(
	.enable_n(enable_n),
	.reset(reset),
	.hsync(hsync),
	.vsync(vsync)
);

Decoder red_dec(
	.color_in(red),
	.color_out(red_decoded)
);

Mux red_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(red_decoded),
	.display(red_display)
);

Decoder green_dec(
	.color_in(green),
	.color_out(green_decoded)
);

Mux green_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(green_decoded),
	.display(green_display)
);

Decoder blue_dec(
	.color_in(blue),
	.color_out(blue_decoded)
);

Mux blue_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(blue_decoded),
	.display(blue_display)
);

endmodule