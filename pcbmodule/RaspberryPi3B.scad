// pcb
// pcb of the module
// This module is not intended to be 3D printed

include <pcbmodule_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <bracket.scad>

w1=57;
l1=20;
z1=49;
z2=56;
zm=(pcb_y1+pcb_y2)/2;
x1=23;
x2=58;
x3=85;
y1=14;

module pcb(){
  echo("pcb");  
  color("greenyellow")
  difference(){
    union(){  
        cube([motherboard_w,pcb_thick,pcb_h]); // pcb
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
        cylinder(d=pcb_d,h=3*pcb_thick,center=true,$fn=16);
      }
    }
    
    // cut out for USB and Ethernet and opposite cut
    for(x=[-0.1,x3]){ // mounting holes
      translate([x,-pcb_thick/2,zm-w1/2])cube([l1,pcb_thick*2,w1]);
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
    cylinder(d=z2,h=3*pcb_thick,center=true,$fn=64);
  }
}
//rotate([90,0,0])
//pcb();

module RaspberryPi3Bback(){
    h=8;
    w=8;
    z=40;
    zd=20;
    
    difference(){
        translate([0,0,0])bracket(type=1);
        
        for(i=[-1,0,1]){
            translate([motherboard_w,h/2+pcb_thick+step/2,z+w/2+i*zd])
              cube([bracket_x1,h,w],center=true);     
            translate([motherboard_w,h+pcb_thick+step/2-h,z+h/2+i*zd])
            rotate([0,90,0])
              cylinder(h=bracket_x1,d=h,center=true, $fn=16);
        }         
    }
}
//rotate([0,90,0])
//RaspberryPi3Bback();

module RaspberryPi3Bfront(){
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
        bracket(type=0);
        translate([0,h1/2+pcb_thick-y1,z1+w1/2])cube([bracket_x1,h1,w1],center=true); 
        translate([0,h2/2+pcb_thick-y2,z2+w2/2])cube([bracket_x1,h2,w2],center=true); 
        translate([0,h3/2+pcb_thick-y3,z3+w3/2])cube([bracket_x1,h3,w3],center=true);         
    }
}
//
rotate([0,-90,0])
//
RaspberryPi3Bfront();