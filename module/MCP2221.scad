// MCP2221 module
// ==============

MCP2221="assembly"; // [assembly,front,back,print_front,print_back]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module MCP2221_back(){
    h=12;
    w=13;
    z=31;
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        translate([
          0,
          h/2+pcb_h,
          z+w/2])
        cube([
          bracket_h,
          h,
          w],center=true);       
    }
}

module MCP2221_front(){
    h1=12;
    w1=12;
    z1=29;
    
    d2=4;
    h2=3;
    z2=66;
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
          h2+pcb_h,
          z2])rotate([0,90,0])
          cylinder(h=bracket_h,d=d2,center=true, $fn=16);          
    }
}

module MCP2221_assembly(){
    pcb_assembly();
    MCP2221_front();
    translate([pcb_l,0,0])MCP2221_back();
}

if(MCP2221=="front"){
  MCP2221_front();
}

if(MCP2221=="back"){
  MCP2221_back();
}

if(MCP2221=="assembly"){
  MCP2221_assembly();
}

if(MCP2221=="print_front"){
  rotate([0,-90,0])
    MCP2221_front();
}

if(MCP2221=="print_back"){
  rotate([0,90,0])MCP2221_back();
}
