// RS232 module
// ============

RS232="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module RS232_back(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
}

module RS232_front(){
    h1=13.5;
    w1=32;
    z1=29;
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=1);
          translate([
          0,
          h1/2+pcb_h,
          z1+w1/2])
        cube([
          bracket_h,
          h1,
          w1],center=true);
    }
}

module RS232_assembly(){
    pcb_assembly();
    RS232_front();
    translate([pcb_l,0,0])RS232_back();
}

if(RS232=="front"){
  RS232_front();
}

if(RS232=="back"){
  RS232_back();
}

if(RS232=="assembly"){
  RS232_assembly();
}

if(RS232=="print_front"){
  rotate([0,-90,0])
    RS232_front();
}

if(RS232=="print_back"){
  rotate([0,90,0])RS232_back();
}
