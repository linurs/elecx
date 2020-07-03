// BatDoc module
// =============

BatDoc="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module BatDoc_back(){
    translate([0,0,bracket_offset_z])back_bracket(n=2);
}

module BatDoc_front(){
    d1=7;
    h1=10;
    z1=20;
    y1=2;
    
    d2=7;
    h3=10;
    z2=65;
    
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=2);
    
        for(i=[-1,1]){
          translate([
            0,
            i*h1+2*h1+pcb_h,
            z1])rotate([0,90,0])
          cylinder(h=bracket_h,d=d1,center=true, $fn=16); 
          
          translate([
            0,
            i*h1+2*h1+pcb_h,
            z1])
          cube([bracket_h,y1,d1+2*y1],center=true); 
        }
 
        translate([
          0,
          h3+pcb_h,
          z2])rotate([0,90,0])
        cylinder(h=bracket_h,d=d2,center=true, $fn=16);      
    }
}

module BatDoc_assembly(){
    pcb_assembly();
    BatDoc_front();
    translate([pcb_l,0,0])BatDoc_back();
}

if(BatDoc=="assembly"){
  BatDoc_assembly();
}

if(BatDoc=="front"){
   BatDoc_front();
}

if(BatDoc=="back"){
   BatDoc_back();
}

if(BatDoc=="print_front"){
  rotate([0,-90,0])
    BatDoc_front();
}

if(BatDoc=="print_back"){
  rotate([0,90,0])BatDoc_back();
}