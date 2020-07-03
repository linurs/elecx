// FT311 module
// ==========

FT311="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module FT311_back(){
    translate([0,0,bracket_offset_z])back_bracket(n=1);
}

module FT311_front(){
    
    h1=8;
    w1=15;
    z1=22;
    
    dled=3.5;
    hled=dled/2;
    z2=43;
    z3=71;
          
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
               
        translate([
          0,
          hled+pcb_h,
          z2])rotate([0,90,0])
        cylinder(h=bracket_h,d=dled,center=true, $fn=16); 
          
        translate([
          0,
          hled+pcb_h,
          z3])rotate([0,90,0])
        cylinder(h=bracket_h,d=dled,center=true, $fn=16); 
    }
}

module FT311_assembly(){
    pcb_assembly();
    FT311_front();
    translate([pcb_l,0,0])FT311_back();
}

if(FT311=="front"){
  FT311_front();
}

if(FT311=="back"){
  FT311_back();
}

if(FT311=="assembly"){
  FT311_assembly();
}

if(FT311=="print_front"){
  rotate([0,-90,0])
    FT311_front();
}

if(FT311=="print_back"){
  rotate([0,90,0])FT311_back();
}
