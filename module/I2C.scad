// I2C module
// ==========

I2C="assembly"; // [assembly,front,back, print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module I2C_back(){
    h1=12;
    w1=13;
    z1=31;
    
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
    }
}

module I2C_front(){
    h1=13;
    w1=25;
    z1=21;
    
    dx=5.5;
    hx=5;
    z2=49;
    z3=57;
    
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
        
        translate([
          0,
          hx,
          z2])rotate([0,90,0])
          cylinder(h=bracket_h,d=dx,center=true, $fn=16);    
        
        translate([
          0,
          hx,
          z3])rotate([0,90,0])
          cylinder(h=bracket_h,d=dx,center=true, $fn=16);      
    }
}

module I2C_assembly(){
    pcb_assembly();
    I2C_front();
    translate([pcb_l,0,0])I2C_back();
}

if(I2C=="assembly"){
  I2C_assembly();
}

if(I2C=="front"){
  I2C_front();
}

if(I2C=="back"){
  I2C_back();
}

if(I2C=="print_front"){
  rotate([0,-90,0])
    I2C_front();
}

if(I2C=="print_back"){
  rotate([0,90,0])I2C_back();
}