// pcb
// pcb of the module
// This module is not intended to be 3D printed

include <../motherboard/motherboard_dim.scad>
include <pcbmodule_dim.scad>


module pcb(){
  echo("pcb");  
  color("greenyellow")
  difference(){
    cube([motherboard_w,pcb_thick,pcb_h]); // pcb
    for(x=[pcb_x1,pcb_x2]){ // mounting holes
      for(y=[pcb_y1,pcb_y2]){
        translate([x,0,y])
        rotate([90,0,0])
        cylinder(d=pcb_d,h=3*pcb_thick,center=true,$fn=16);
      }
    }
  }
}

//
pcb();