// Stepper module
// ==============

Fet="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module Fet_back(){
    h1=14;
    w1=51;
    z1=15;
    
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          h1/2,
          z1+w1/2])
        cube([
          bracket_h,
          h1,
          w1],center=true); 
    }
}

module Fet_front(){
   translate([0,0,bracket_offset_z])front_bracket(n=1);
}

module Fet_assembly(){
    pcb_assembly();
    Fet_front();
    translate([pcb_l,0,0])Fet_back();
}

if(Fet=="assembly"){
  Fet_assembly();
}

if(Fet=="front"){
   Fet_front();
}

if(Fet=="print_back"){
  Fet_back();
}

if(Fet=="print_front"){
  rotate([0,-90,0])
    Fet_front();
}

if(Fet=="print_back"){
  rotate([0,90,0])Fet_back();
}