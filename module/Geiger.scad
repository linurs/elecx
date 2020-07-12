// Geiger module
// ==========

Geiger="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module Geiger_back(){
    d1=3;
    d1_1=13;
    d1_2=15;
    h1=d1_2/2;
    z1=55;
    x1=3;
    
    d2=5.5;
    h2=h1;
    z2=70;
    
    difference(){
        union(){
            translate([0,0,bracket_offset_z])back_bracket(n=2);
            
            translate([
              bracket_gap-x1/2,
              h1+pcb_h,
              z1])rotate([0,90,0])
            cylinder(h=x1,d=d1_2,center=true, $fn=16); 
        }
        translate([
          0,
          h1+pcb_h,
          z1])rotate([0,90,0])
        cylinder(h=bracket_h,d=d1,center=true, $fn=16); 
        
        translate([
          bracket_gap-bracket_h/2,
          h1+pcb_h,
          z1])rotate([0,90,0])
        cylinder(h=bracket_h,d=d1_1,center=true, $fn=16); 
        
        translate([
          0,
          h2+pcb_h,
          z2])rotate([0,90,0])
        cylinder(h=bracket_h,d=d2,center=true, $fn=16); 
        
        
    }
}

module Geiger_front(){
    
    d1=3.5;
    h1=d1/2;
    z1=27.5;
    
    h2=12;
    w2=17;
    z2=33.5;
    
    hl=4;
    hl1=2;
    wl=2;
    z3=57.5;
    z4=66;
        
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=2);
        
        translate([
          0,
          h1+pcb_h,
          z1])rotate([0,90,0])
          cylinder(h=bracket_h,d=d1,center=true, $fn=16); 
        
        translate([
          0,
          h2/2+pcb_h,
          z2+w2/2])
        cube([
          bracket_h,
          h2,
          w2],center=true);
        
        translate([
          0,
          hl/2+pcb_h+hl1,
          z3+wl/2])
        cube([
          bracket_h,
          hl,
          wl],center=true);
          
        translate([
          0,
          hl/2+pcb_h+hl1,
          z4+wl/2])
        cube([
          bracket_h,
          hl,
          wl],center=true);  
    }
}

module Geiger_assembly(){
    pcb_assembly();
    Geiger_front();
    translate([pcb_l,0,0])Geiger_back();
}

if(Geiger=="front"){
  Geiger_front();
}

if(Geiger=="back"){
  Geiger_back();
}

if(Geiger=="assembly"){
  Geiger_assembly();
}

if(Geiger=="print_front"){
  rotate([0,-90,0])
    Geiger_front();
}

if(Geiger=="print_back"){
  rotate([0,90,0])Geiger_back();
}
