// BeagleBone module
// ==============

BeagleBone="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module BeagleBone_back(){
    h1=2;//
    hb=12.5;
    w1=55;
    z1=21;
    
    h2=5;
    w2=11;
    z2=26;
    
    h3=14;
    w3=17;
    z3=38;
    
    h4=11.5;
    w4=9.5;
    z4=62;
    
    difference(){
        
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          h1/2+hb,
          z1+w1/2])
        cube([
          bracket_h,
          h1,
          w1],center=true);
        
        translate([
          0,
          h2/2+hb+h1,
          z2+w2/2])
        cube([
          bracket_h,
          h2,
          w2],center=true);
        
        translate([
          0,
          hb-h3/2,
          z3+w3/2])
        cube([
          bracket_h,
          h3,
          w3],center=true);
          
        translate([
          0,
          hb-h4/2,
          z4+w4/2])
        cube([
          bracket_h,
          h4,
          w4],center=true);  
    }
}

module BeagleBone_front(){
    translate([0,0,bracket_offset_z])front_bracket(n=1);
}

module BeagleBone_assembly(){
    pcb_assembly();
    BeagleBone_front();
    translate([pcb_l,0,0])BeagleBone_back();
}

if(BeagleBone=="assembly"){
  BeagleBone_assembly();
}

if(BeagleBone=="front"){
  BeagleBone_front();
}

if(BeagleBone=="back"){
  BeagleBone_back();
}

if(BeagleBone=="print_front"){
  rotate([0,-90,0])
    BeagleBone_front();
}

if(BeagleBone=="print_back"){
  rotate([0,90,0])BeagleBone_back();
}
