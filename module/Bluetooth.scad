// Bluetooth module
// ==========

Bluetooth="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module Bluetooth_back(){
    translate([0,0,bracket_offset_z])back_bracket(n=1);
}

module Bluetooth_front(){
    d=3;
    h=3.5;
    z=51.5;
       
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=1);
        
        translate([
          0,
          h+pcb_h,
          z])rotate([0,90,0])
          cylinder(h=bracket_h,d=d,center=true, $fn=16);       
    }
}

module Bluetooth_assembly(){
    pcb_assembly();
    Bluetooth_front();
    translate([pcb_l,0,0])Bluetooth_back();
}

if(Bluetooth=="front"){
  Bluetooth_front();
}

if(Bluetooth=="back"){
  Bluetooth_back();
}

if(Bluetooth=="assembly"){
  Bluetooth_assembly();
}

if(Bluetooth=="print_front"){
  rotate([0,-90,0])
    Bluetooth_front();
}

if(Bluetooth=="print_back"){
  rotate([0,90,0])Bluetooth_back();
}
