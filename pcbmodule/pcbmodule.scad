// module (pcb assembly)
// A series of assembled modules
// This module is not intended to be 3D printed
include <../motherboard/motherboard_dim.scad>
include <pcbmodule_dim.scad>

use <bracket.scad>
use <pcb.scad>
use <../library/din41612/connector.scad>

module pcbmodule(n=1){
  for(i=[1:n]){
    translate([0,(i-1)*step,0]){
      pcb();
      translate([(motherboard_w-con_w)/2,0,-pcbmodule_con_out])  connector();
      bracket();
      bracket(type=1);
    }
  }
}

n=1;
//
pcbmodule(n=n);
//connector();

module head_bracket(){

difference(){
    union(){
        cube([100-1,step-4-1.6-2.5,2]);
        for(i=[0,100-8-0.5]){
        translate([i,0,-6])
        cube([8-0.5,step-4-1.6-2.5,8]);
        }    
    }
    for(x=[pcb_x1,pcb_x2]){ // mounting holes
            translate([x-0.5,0,-2])
            rotate([90,0,0])
            cylinder(d=pcb_d,h=30*pcb_thick,center=true,$fn=16);
    
        }

}
}

translate([0.5,1.6,80-2])
head_bracket();
