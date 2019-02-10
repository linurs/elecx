// elecbox
include <../library/linurs_screw_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../pcbmodule/pcbmodule_dim.scad>
include <../wall/wall_dim.scad>

// foot constants
foot_motherboard_z=8; // z distance of free space under motherboard
foot_motherboard_f=8;  // motherboard support distance
foot_side_wall_t=1;    // thickness of side wall
foot_min_y=step+2*(wall_y+foot_side_wall_t); // 1 module y dimension of the foot

foot_step=pcbmodule_con_out+motherboard_con_out+motherboard_t+bracket_offset_z; // motherboard solder side to bracket
foot_step1=foot_step; // step for the wall fixation cubes

foot_bottom_t=1;                                    // bottom thickness
foot_side_wall_h=5;                                 // height of side wall
foot_z=foot_step1+foot_motherboard_z+foot_bottom_t; // functional z dimension of foot 
foot_outer_z=foot_z+foot_side_wall_h;               // outside z dimension of foot
foot_x=motherboard_w-2*bracket_offset_x+2*foot_side_wall_t; // x dimension of foot

//foot offsets
foot_offset_x=bracket_offset_x-foot_side_wall_t; // x dimension 
foot_offset_y=-wall_fix_y-foot_side_wall_t;      // y dimension 
foot_offset_z=bracket_offset_z-foot_z;           // z dimension 

// enumerations for foot fixing variants
foot_type_none=0;
foot_type_dinrail=1;
foot_type_bracket=2;

// marking dimensions for foot_type_feed
foot_marking_in=4;
foot_marking_d=6;
foot_marking_h=0.5;

// bracket dimension for foot_type_bracket
foot_bracket_t=3;
foot_bracket_x=10;
foot_bracket_y=10;
foot_bracket_d=4;
foot_bracket_enforce_d=5;