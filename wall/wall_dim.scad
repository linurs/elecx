include <../library/linurs/linurs_screw_dim.scad>
include <../motherboard/motherboard_dim.scad>

// wall constants
wall_t=1;        // wall thickness

wall_y=5;        // wall outside thickness
wall_fix_y=9;    // thickness of the wall fix cube
wall_gap_x=motherboard_w-2*wall_fix_y; // remove material between both wall fixation cubes
wall_head_fix_h=5; // height of the head fixing cube
wall_screw=M3;
wall_screw_t=0.8;// gap added for screws

wall_d_w=76;     // distance between wall fixation screws
wall_d_y=(wall_fix_y-wall_t)/2; // y position of the wall fixation screws
