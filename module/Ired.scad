// Ired module
// ==========

Ired="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module Ired_back(){
    d1=3.5;
    h1=9;
    z1=52;
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
           
        translate([
          0,
          h1+pcb_h,
          z1])rotate([0,90,0])
          cylinder(h=bracket_h,d=d1,center=true, $fn=16);
    }
}

module Ired_front(){
    dir=5;
    drx=4;
    dled=3;
    
    hir=dir/2;
    hrx=6;
    hled=dled/2;
    
    z1=38;
    z2=44;
    z3=57.5;
    z4=65;
    z5=70;
     
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=1);
        
        translate([
          0,
          hir+pcb_h,
          z1])rotate([0,90,0])
          cylinder(h=bracket_h,d=dir,center=true, $fn=16); 
      
       translate([
          0,
          hir+pcb_h,
          z2])rotate([0,90,0])
          cylinder(h=bracket_h,d=dir,center=true, $fn=16);     
        
       translate([
          0,
          hrx+pcb_h,
          z3])rotate([0,90,0])
          cylinder(h=bracket_h,d=dir,center=true, $fn=16);    
        
       translate([
          0,
          hled+pcb_h,
          z4])rotate([0,90,0])
          cylinder(h=bracket_h,d=dled,center=true, $fn=16);   
          
       translate([
          0,
          hled+pcb_h,
          z5])rotate([0,90,0])
          cylinder(h=bracket_h,d=dled,center=true, $fn=16);      
    }
}

module Ired_assembly(){
    pcb_assembly();
    Ired_front();
    translate([pcb_l,0,0])Ired_back();
}

if(Ired=="front"){
  Ired_front();
}

if(Ired=="back"){
  Ired_back();
}

if(Ired=="assembly"){
  Ired_assembly();
}

if(Ired=="print_front"){
  rotate([0,-90,0])
    Ired_front();
}

if(Ired=="print_back"){
  rotate([0,90,0])Ired_back();
}


