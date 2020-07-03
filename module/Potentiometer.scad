// Potentiometer module
// ==========

Potentiometer="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module Potentiometer_back(){
    translate([0,0,bracket_offset_z])back_bracket(n=1);
}

module Potentiometer_front(){
    dadj=4;
    dpot=8;
  
    hadj=4.5;
    hpot=9;
 
    zpot=30;
    zadj=22.5;
       difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=1);
        
        translate([
          0,
          hadj+pcb_h,
          zpot-zadj/2])rotate([0,90,0])
          cylinder(h=bracket_h,d=dadj,center=true, $fn=16); 
      
       translate([
          0,
          hpot+pcb_h,
          zpot])rotate([0,90,0])
          cylinder(h=bracket_h,d=dpot,center=true, $fn=16);     
        
       translate([
          0,
          hadj+pcb_h,
          zpot+zadj/2])rotate([0,90,0])
          cylinder(h=bracket_h,d=dadj,center=true, $fn=16);        
    }
}

module Potentiometer_assembly(){
    pcb_assembly();
    Potentiometer_front();
    translate([pcb_l,0,0])Potentiometer_back();
}

if(Potentiometer=="front"){
  Potentiometer_front();
}

if(Potentiometer=="back"){
  Potentiometer_back();
}

if(Potentiometer=="assembly"){
  Potentiometer_assembly();
}

if(Potentiometer=="print_front"){
  rotate([0,-90,0])
    Potentiometer_front();
}

if(Potentiometer=="print_back"){
  rotate([0,90,0])Potentiometer_back();
}
