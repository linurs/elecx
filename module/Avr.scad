// Avr module
// ==========

Avr="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module Avr_back(){
    h=4;
    w=42;
    z=30;
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          h/2+18,
          z+w/2])
        cube([
          bracket_h,
          h,
          w],center=true);       
    }
}

module Avr_front(){
    h1=11.5;
    w1=20;
    z1=50;
    
    d2=3.2;
    h2=h1/2;
    z2=25.4;
    
    h3=step;
    w3=1;
    z3=z1+w1/2;
    
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
        
        for(i=[-1,1]){
        translate([
          0,
          h2+pcb_h,
          z1+w1/2+i*z2/2])rotate([0,90,0])
          cylinder(h=bracket_h,d=d2,center=true, $fn=16);
        }   
        
        translate([
          0,
          h3/2+pcb_h,
          z3+w3/2])
        cube([
          bracket_h,
          h3,
          w3],center=true);       
    }
}

module Avr_assembly(){
    pcb_assembly();
    Avr_front();
    translate([pcb_l,0,0])Avr_back();
}

if(Avr=="front"){
  Avr_front();
}

if(Avr=="back"){
  Avr_back();
}

if(Avr=="assembly"){
  Avr_assembly();
}

if(Avr=="print_front"){
  rotate([0,-90,0])
    Avr_front();
}

if(Avr=="print_back"){
  rotate([0,90,0])Avr_back();
}
