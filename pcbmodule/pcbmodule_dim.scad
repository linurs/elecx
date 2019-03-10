include <../library/linurs/linurs_screw_dim.scad>
include <../motherboard/motherboard_dim.scad>
// pcb constants
pcb_h=80;              // height of the pcb
pcb_thick=1.6;         // thickness
pcb_x1=3;              // position mounting holes
pcb_x2=97;
pcb_y1=9;
pcb_y2=76;
pcb_d=3;               // diameter of holes

// bracket constants
bracket_t=2;           // thickness of bracket
bracket_x1=10;         // depth of the U shape at the side of the screw
bracket_x2=4;          // depth of the U shape at the side where no screw is  
bracket_h=pcb_h+15;    // height of bracket
bracket_hole_cube_h=4; // height of the mounting hole cube
bracket_screw=M2_5;    // hole for the screw

// bracket offsets
bracket_offset_x=-3;   // bracket offset in elecbox x axis (adding gap)
bracket_offset_z=-10;  // bracket offset in elecbox z axis

// pcb module dimensions
pcbmodule_w=(-bracket_offset_x)*2+motherboard_w; // depth of the module
pcbmodule_h=bracket_h;                           // hight of the module   
pcbmodule_l=step;                                // width of the module   

screw_t=1; //mm added so screws fit into holes
olp=0.1; // overlapp distance to produce nice body after difference() 