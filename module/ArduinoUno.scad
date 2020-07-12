// Arduino uno module
// ==================

arduino_uno="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module arduino_uno_back(){
    h1=12;
    w1=13;
    z1=29;
   
    h2=12;
    w2=10;
    z2=61;
    
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          pcb_h+h1/2,
          z1+w1/2])
        cube([
          bracket_h,
          h1,
          w1],center=true);
            
        translate([
          0,
          pcb_h+h2/2,
          z2+w2/2])
        cube([
          bracket_h,
          h2,
          w2],center=true); 
     
        
    }
}

module arduino_uno_front(){
    translate([0,0,bracket_offset_z])front_bracket(n=1);
}

module arduino_uno_assembly(){
    pcb_assembly();
    arduino_uno_front();
    translate([pcb_l,0,0])arduino_uno_back();
}

if(arduino_uno=="assembly"){
  arduino_uno_assembly();
}

if(arduino_uno=="front"){
  arduino_uno_front();
}

if(arduino_uno=="back"){
  arduino_uno_back();
}

if(arduino_uno=="print_front"){
  rotate([0,-90,0])
    arduino_uno_front();
}

if(arduino_uno=="print_back"){
  rotate([0,90,0])arduino_uno_back();
}
