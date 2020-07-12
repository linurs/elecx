// AvrCtrl module
// ==============

AvrCtrl="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module AvrCtrl_back(){
    h1=12.5;
    w1=12;
    z1=14;
 
    h2=10;
    w2=39;
    z2=34.5;
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          h1/2+pcb_h,
          z1+w1/2])
        cube([
          bracket_h,
          h1,
          w1],center=true);
        
        translate([
          0,
          h2/2+pcb_h,
          z2+w2/2])
        cube([
          bracket_h,
          h2,
          w2],center=true);
        // bracket under cut for solder points of WAGO connector
        translate([  
          -9,
          -2,
          -12])
        cube([
          5,
          4,
          100]);
    }
}

module AvrCtrl_front(n=1){
    h1=14;
    w1=32;
    z1=12.5;
    
    h2=11.5;
    w2=13;
    z2=46.5;
    
    d3=4;
    h3=4.5;
    z3=67;
    
    d4=4.8;  //4.4 Loch 5 Ring
    h4=12;
    z4=63.5;
    
    d5=d4;
    h5=h4;
    z5=69.5;
    
    h6=9;
    
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
        
        translate([
          0,
          h2/2+pcb_h,
          z2+w2/2])
        cube([
          bracket_h,
          h2,
          w2],center=true);
        
        translate([
          -0.5,
          h6/2+pcb_h,
          z3])
        cube([
          4,
          h6,
          h6],center=true);    
        
        translate([
          0,
          h3+pcb_h,
          z3])rotate([0,90,0])
        cylinder(h=bracket_h,d=d3,center=true, $fn=16); 
        
        translate([
          0,
          h4+pcb_h,
          z4])rotate([0,90,0])
        cylinder(h=bracket_h,d=d4,center=true, $fn=16);   
        
        translate([
          0,
          h5+pcb_h,
          z5])rotate([0,90,0])
        cylinder(h=bracket_h,d=d5,center=true, $fn=16);   
    }
}

module AvrCtrl_assembly(){
    pcb_assembly();
    AvrCtrl_front();
    translate([pcb_l,0,0])AvrCtrl_back();
}

if(AvrCtrl=="assembly"){
  AvrCtrl_assembly();
}

if(AvrCtrl=="front"){
  AvrCtrl_front();
}

if(AvrCtrl=="back"){
  AvrCtrl_back();
}

if(AvrCtrl=="print_front"){
  rotate([0,-90,0])
    AvrCtrl_front();
}

if(AvrCtrl=="print_back"){
  rotate([0,90,0])AvrCtrl_back();
}
