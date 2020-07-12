// ArduinoMegaMega module
// ==============

ArduinoMega="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module ArduinoMega_back(){
    a1=1;
    
    h1=12;
    w1=13;
    z1=52.5;
   
    h2=12;
    w2=10;
    z2=24;
    
    a2=12;
    
    h3=2;
    w3=54;
    z3=21.5;
    
    difference(){
        
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          a1+h1/2,
          z1+w1/2])
        cube([
          bracket_h,
          h1,
          w1],center=true);
        
        translate([
          0,
          a1+h2/2,
          z2+w2/2])
        cube([
          bracket_h,
          h2,
          w2],center=true);
        
        // ArduinoMegaMega pcb cut out
        translate([
          0,
          a1+a2+h3/2,
          z3+w3/2])
        cube([
          bracket_h,
          h3,
          w3],center=true);
    }
}

module ArduinoMega_front(){
    translate([0,0,bracket_offset_z])front_bracket(n=1);
}

module ArduinoMega_assembly(){
    pcb_assembly();
    ArduinoMega_front();
    translate([pcb_l,0,0])ArduinoMega_back();
}

if(ArduinoMega=="assembly"){
  ArduinoMega_assembly();
}

if(ArduinoMega=="front"){
  ArduinoMega_front();
}

if(ArduinoMega=="back"){
  ArduinoMega_back();
}

if(ArduinoMega=="print_front"){
  rotate([0,-90,0])
    ArduinoMega_front();
}

if(ArduinoMega=="print_back"){
  rotate([0,90,0])ArduinoMega_back();
}
