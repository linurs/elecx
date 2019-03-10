// module (pcb assembly)
// A series of assembled modules
// This module is not intended to be 3D printed
include <../motherboard/motherboard_dim.scad>

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
