// RaspberryPi3B module
// ====================

RaspberryPi3B="assembly"; // [assembly, mount, front, back, print_front, print_back, print_mount]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module mount(){
  echo("mount");  
  w1=57;
  l1=20;
  z1=49;
  z2=56;
  pcb_y2=76;
  pcb_y1=9;  
  pcb_x1=3;
  pcb_x2=97;  
  zm=(pcb_y1+pcb_y2)/2;  
  x1=23;
  x2=58;
  x3=85;
  y1=14;  
  color("greenyellow")
    
  difference(){
    union(){  
        cube([pcb_l,pcb_h,pcb_w]); // pcb
        for(x=[0,1]){ // spacers
          for(z=[-1,1]){
            translate([x*x2+x1,y1/2,z*z1/2+zm])  
            cube([2*pcb_d,y1,2*pcb_d],center=true);
          }
        }  
        translate([x1-pcb_d,0,-z1/2-2*pcb_d+zm])  // spacer wall
        cube([x2+2*pcb_d,y1,pcb_d]);

        translate([x1-pcb_d,0,z1/2+pcb_d+zm])  // spacer wall
        cube([x2+2*pcb_d,6,pcb_d]);
    }
    
    for(x=[pcb_x1,pcb_x2]){ // mount mounting holes
      for(y=[pcb_y1,pcb_y2]){
        translate([x,0,y])
        rotate([90,0,0])
        cylinder(d=pcb_d,h=3*pcb_h,center=true,$fn=16);
      }
    }
    
    // cut out for USB and Ethernet and opposite cut
    for(x=[-0.1,x3]){ // mounting holes
      translate([x,-pcb_h/2,zm-w1/2])cube([l1,pcb_h*2,w1]);
    }
    // raspi mounting holes
    for(x=[0,1]){ // mounting holes
      for(z=[-1,1]){
        translate([x*x2+x1,0,z*z1/2+zm])
        rotate([90,0,0])
        cylinder(d=pcb_d,h=3*y1,center=true,$fn=16);
      }
    }
    // hole to save material
    translate([x1+x2/2,0,zm]) 
    rotate([90,0,0])
    cylinder(d=z2,h=3*pcb_h,center=true,$fn=64);
  }
}

module RaspberryPi3B_back(){
    h=8;
    w=8;
    z=40;
    zd=20;
    
    difference(){
        translate([0,0,bracket_offset_z])back_bracket(n=1);
        
        for(i=[-1,0,1]){
            translate([
              0,
              h/2+pcb_h+step/2,
              z+w/2+i*zd])
            cube([
              bracket_h,
              h,
              w],center=true);     
            
            translate([
              0,
              h+pcb_h+step/2-h,
              z+h/2+i*zd])
              rotate([0,90,0])
              cylinder(h= bracket_h,d=h,center=true, $fn=16);
        }         
    }
}

module RaspberryPi3B_front(){
    Eth_h=14.5;
    Eth_w=17.5;
    
    Usb_h=17;
    Usb_w=16;
    
    y3=3;
    h3=Usb_h;
    w3=Usb_w;
    z3=16;//17.5;
    
    y2=3;
    h2=Usb_h;
    w2=Usb_w;
    z2=z3+18;
    
    y1=1.6;
    h1=Eth_h;
    w1=Eth_w;
    z1=z2+18;
    
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=1);
        
        translate([
          0,
          h1/2+pcb_h-y1,
          z1+w1/2])
        cube([
          bracket_h,
          h1,
          w1],center=true); 
        
        translate([
          0,
          h2/2+pcb_h-y2,
          z2+w2/2])
        cube([
          bracket_h,
          h2,
          w2],center=true); 
        
        translate([
          0,
          h3/2+pcb_h-y3,
          z3+w3/2])
        cube([
          bracket_h,
          h3,
          w3],center=true);         
    }
}

module RaspberryPi3B_assembly(){
    mount();
    RaspberryPi3B_front();
    translate([pcb_l,0,0])RaspberryPi3B_back();
}

if(RaspberryPi3B=="mount"){
  mount();
}

if(RaspberryPi3B=="assembly"){
  RaspberryPi3B_assembly();
}

if(RaspberryPi3B=="front"){
  RaspberryPi3B_front();
}

if(RaspberryPi3B=="back"){
  RaspberryPi3B_back();
}

if(RaspberryPi3B=="print_front"){
  rotate([0,-90,0])
    RaspberryPi3B_front();
}

if(RaspberryPi3B=="print_back"){
  rotate([0,90,0])
    RaspberryPi3B_back();
}

if(RaspberryPi3B=="print_mount"){
     rotate([90,0,0])
  mount();
}

