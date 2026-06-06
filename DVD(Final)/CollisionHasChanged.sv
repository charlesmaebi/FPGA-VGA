// ============================================================================
// Project Name: CollisionHasChanged
// Author:       Charles Aebi
// Description:  Checks if either collision_h or collision_v has changed
// ============================================================================

module CollisionHasChanged(
	input logic clock50,
	input logic reset,
	input logic collision_h,
	input logic collision_v,
	output logic collision_has_changed
);

logic prev_collision_h, prev_collision_v;

always_ff @(posedge clock50) begin
	if (reset) begin
		prev_collision_h      <= 1'b0;
      prev_collision_v      <= 1'b0;
      collision_has_changed <= 1'b0;
   end 
	else begin
      prev_collision_h      <= collision_h;
      prev_collision_v      <= collision_v;

		// collsion has changed is high if either collision doesnt equal the respective previous collision	
      collision_has_changed <= (collision_h != prev_collision_h) || (collision_v != prev_collision_v);
   end
end

endmodule
	
