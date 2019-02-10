// motherboard
// Connector to be mounted on the motherboard pcb
// This module is not intended to be 3D printed
// set type to 1 to get dummy conector

include <motherboard_dim.scad>
include <../library/linurs_screw_dim.scad>
use <../library/linurs_screw.scad>

module motherboard_con(type=0){
  color("LightGrey")
  difference(){
    union(){
      if(type==0){  
        cube([motherboard_con_head_w,
              motherboard_con_head_d,
              motherboard_con_h],
              center=true);  // upper body of the connector down to motherboard level
      }    
      translate([0,0,-(motherboard_con_h-motherboard_con_out)/2])
        cube([motherboard_con_w,
              motherboard_con_t,
              motherboard_con_out],
              center=true); // lower body of the connector laying on mother board
    }
    for(i=[-1,1]){ // mounting holes
      translate([i*motherboard_con_d_w/2,
                 0,
                 -(motherboard_con_h-motherboard_con_out)/2])
      screw(w=motherboard_con_out+0.1, d=M2_5, type=head_cyl, t=1);
    }
  }
}

//motherboard_con();
//
motherboard_con(type=1);


