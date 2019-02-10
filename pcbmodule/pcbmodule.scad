// module (pcb assembly)
// A series of assembled modules
// This module is not intended to be 3D printed
include <../motherboard/motherboard_dim.scad>

use <bracket.scad>
use <pcb.scad>
use <connector.scad>

module pcbmodule(n=1){
  for(i=[1:n]){
    translate([0,(i-1)*step,0]){
      pcb();
      connector();
      bracket();
      bracket(type=1);
    }
  }
}


//pcbmodule(n=1);
connector();
