// connector
// Connector to be mounted on pcb of the modules
// This module is not intended to be 3D printed
include <pcbmodule_dim.scad>
include <../motherboard/motherboard_dim.scad>

use <pcb.scad>

con_w=87.5;   // width of connector bodywithout flanges of mounting holes 
con_d=2.8;    // diameter of mounting holes
con_d_w=88.9; // distance between mounting holes
con_m_h=6;    // height of mounting cube
con_h=13;     // largest z dimension

module connector(){
  echo("pcb connector");
  color("LightGrey")
  difference(){
    translate([(motherboard_w-con_w)/2,0,-pcbmodule_con_out]) // bring in position of elecbox
    union(){
      cube([con_w,motherboard_con_t,con_h]); // main body of the connector
      for(x=[(con_w-con_d_w)/2,con_w+(con_d_w-con_w)/2]){ // add the two brackets
        translate([x,con_m_h/2+pcb_thick,10.2])
        difference(){
          cube([2*con_d,con_m_h,2*con_d],center=true);  // bracket main body
          rotate([90,0,0])
          cylinder(d=con_d, h=con_h, $fn=16, center=true); // hole in brackets
        }
      }
    }
    translate([0,-olp,0])cube([motherboard_w,motherboard_t+olp,2*con_d]); // remove material to create edge of pcb
  }
}
connector();

//
pcb();

