// 3DprinterIO module
// ==================

3DprinterIO="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module 3DprinterIO_back(){
    h1=14;
    w1=31;
    z1=12;
 
    h2=14;
    w2=18.5;
    z2=53.5;
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
        
        translate([
          0,
          h2/2,
          z2+w2/2])
        cube([
          bracket_h,
          h2,
          w2],center=true);               
    }
}

module 3DprinterIO_front(){
    h1=11;
    w1=34;
    z1=37.5;
    
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=1);
        
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

module 3DprinterIO_assembly(){
    pcb_assembly();
    3DprinterIO_front();
    translate([pcb_l,0,0])3DprinterIO_back();
}

if(3DprinterIO=="assembly"){
  3DprinterIO_assembly();
}

if(3DprinterIO=="front"){
  3DprinterIO_front();
}

if(3DprinterIO=="back"){
  3DprinterIO_back();
}

if(3DprinterIO=="print_front"){
  rotate([0,-90,0])
    3DprinterIO_front();
}

if(3DprinterIO=="print_back"){
  rotate([0,90,0])3DprinterIO_back();
}