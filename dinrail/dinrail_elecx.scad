// din rail holder for elecx 
// to check how the components interfere

include <../elecx_dim.scad>
include <../library/dinrail/dinrail_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../foot/foot_dim.scad>
include <../library/dinrail/dinrail_holder_dim.scad>

use <../library/dinrail/dinrail.scad>
use <../library/dinrail/dinrail_holder.scad>

module dinrail_elecx_single(type=0){
  if(type==0){
      dinrail_lever_l=motherboard_w-2*bracket_offset_x+2*foot_side_wall_t;
      dinrail_lever(l=dinrail_lever_l);
      dinrail_bracket(l=din_bracket_l);
      // dinrail_holder(l=din_bracket_l);
      
      dinrail_lever_holder(l=din_bracket_l);
  }else{    
    dinrail_screw(dinholder_x=dinholder_x,t=dinholder_pass);  
  }
}

module dinrail_elecx(n=1, type=0){
  if(n<din_two_holder){
  translate([50,
             (foot_min_y+(n-1)*step)/2+foot_offset_y,
             foot_offset_z-dinrail_h
            ])
  dinrail_elecx_single(type=type);
  }else{
    for(y=[foot_offset_y+dinholder_y,
           foot_min_y+(n-1)*step+foot_offset_y-dinholder_y,])  
      translate([50,
             y,
             foot_offset_z-dinrail_h
            ])
            dinrail_elecx_single(type=type);
  }
}

n=4;
//dinrail_elecx(n=n, type=1);
//
dinrail_elecx(n=n, type=0);
//foot(n=n, type=2);

translate([50,
             (foot_min_y+(n-1)*step)/2+foot_offset_y,
             foot_offset_z-dinrail_h])

dinrail(l=100+step*(n-1));