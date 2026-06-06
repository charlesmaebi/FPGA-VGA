// ============================================================================
// Project Name: Collision Testbench
// Author:       Alan Nguyen
// Description:  A testbench made to test the collision module
// ============================================================================

`timescale 1ns / 1ps

module tb_collision();

	// Declare internal testbench signals
	logic clock;
	logic reset;
	logic [9:0] upper, lower, left, right;
	logic collision_pulse_vertical, collision_pulse_horizontal;

	// DUT
	Collision dut (
		.clock(clock),
		.reset(reset),
		.upper(upper),
		.lower(lower),
		.left(left),
		.right(right),
		.collision_pulse_vertical(collision_pulse_vertical),
		.collision_pulse_horizontal(collision_pulse_horizontal)
	);

	// 50MHz Clock 
	always #10 clock = ~clock;

// Test
	initial begin
		// Start in middle of screen
		clock = 0;
		reset = 1;
		upper = 200; lower = 250; 
		left = 300; right = 350;

		// Hold reset for a couple of clock cycles, then release
		#40 reset = 0;
		#20;

		// --- TEST 1: Hit Right Boundary (Changes state to 1) ---
		// Expectation: collision_pulse_horizontal goes from 0 to 1
		right = 790;
		#20; 
		right = 350; // Move back to safe zone
		#40;

		// --- TEST 2: Hit Left Boundary (Changes state to 0) ---
		// Expectation: collision_pulse_horizontal goes from 1 to 0
		left = 140; 
		#20; 
		left = 300; // Move back to safe zone
		#40; 

		// --- TEST 3: Hit Bottom Boundary (Changes state to 1) ---
		// Expectation: collision_pulse_vertical goes from 0 to 1
		lower = 520;
		#20; 
		lower = 250; // Move back to safe zone
		#40;

		// --- TEST 4: Hit Top Boundary (Changes state to 0) ---
		// Expectation: collision_pulse_vertical goes from 1 to 0
		upper = 35;
		#20; 
		upper = 200; // Move back to safe zone
		#40;

		$display("Simulation complete");
		$stop; 
	end

endmodule
