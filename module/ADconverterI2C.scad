// ACconverterI2C module
// ============

ACconverterI2C="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module ACconverterI2C_back(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
}

module ACconverterI2C_front(){
    h1=12;
    w1=12;
    z1=41;
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

module ACconverterI2C_assembly(){
    pcb_assembly();
    ACconverterI2C_front();
    translate([pcb_l,0,0])ACconverterI2C_back();
}

if(ACconverterI2C=="front"){
  ACconverterI2C_front();
}

if(ACconverterI2C=="back"){
  ACconverterI2C_back();
}

if(ACconverterI2C=="assembly"){
  ACconverterI2C_assembly();
}

if(ACconverterI2C=="print_front"){
  rotate([0,-90,0])
    ACconverterI2C_front();
}

if(ACconverterI2C=="print_back"){
  rotate([0,90,0])ACconverterI2C_back();
}
