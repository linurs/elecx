// Stepper module
// ==============

stepper="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module stepper_back(){
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          hx/2,
          z1+wx/2])
        cube([
          bracket_h,
          hx,
          wx],center=true); 
        
        translate([
          0,
          hx/2,
          z2+wx/2])
        cube([
          bracket_h,
          hx,
          wx],center=true); 
        
        translate([
          0,
          hx/2,
          z3+wx/2])
        cube([
          bracket_h,
          hx,
          wx],center=true);        
    }
}

module stepper_front(){
    z4=63.5;
    w4=8;
    
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=1);
        
        translate([
          0,
          hx/2,
          z1+wx/2])
        cube([
          bracket_h,
          hx,
          wx],center=true); 
        
        translate([
          0,
          hx/2,
          z2+wx/2])
        cube([
          bracket_h,
          hx,
          wx],center=true);    
        
        // power connector
        translate([
          0,
          hx/2,
          z4+w4/2])
        cube([
          bracket_h,
          hx,
          w4],center=true);      
    }
}

// to have all wago cut outs the same
hx=14;
wx=14;
z1=15;
z2=30;
z3=45;

module stepper_assembly(){
    pcb_assembly();
    stepper_front();
    translate([pcb_l,0,0])stepper_back();
}

if(stepper=="assembly"){
  stepper_assembly();
}

if(stepper=="front"){
  stepper_front();
}

if(stepper=="back"){
  stepper_back();
}

if(stepper=="print_front"){
  rotate([0,-90,0])
    stepper_front();
}

if(stepper=="print_back"){
  rotate([0,90,0])stepper_back();
}