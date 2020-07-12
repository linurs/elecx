// Uirt module
// ==========

Uirt="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module Uirt_back(){
    d1=4.5;
    h1=5;
    z1=47;
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          h1+pcb_h,
          z1])rotate([0,90,0])
          cylinder(h=bracket_h,d=d1,center=true, $fn=16); 
    }
}

module Uirt_front(){
    h1=13;
    w1=31;
    z1=14;
    
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

module Uirt_assembly(){
    pcb_assembly();
    Uirt_front();
    translate([pcb_l,0,0])Uirt_back();
}

if(Uirt=="front"){
  Uirt_front();
}

if(Uirt=="back"){
  Uirt_back();
}

if(Uirt=="assembly"){
  Uirt_assembly();
}

if(Uirt=="print_front"){
  rotate([0,-90,0])
    Uirt_front();
}

if(Uirt=="print_back"){
  rotate([0,90,0])Uirt_back();
}
