// din rail holder for elecx 

include <../motherboard/motherboard_dim.scad>
include <dinrail_elecx_dim.scad>

use <../library/linurs/linurs_screw.scad>

use <../library/dinrail/dinrail.scad>
use <../library/dinrail/dinrail_holder.scad>

n=4;
dinrail=true;

module dinrail_elecx_single(){
    dinrail_lever(dinholder_x=dinholder_x);
    dinrail_bracket(dinholder_x=dinholder_x);
    dinrail_lever_holder(dinholder_x=dinholder_x);
}

module dinrail_elecx(n=1,dinrail=true){
    echo(din_two_holder);
  if(n<din_two_holder){
    dinrail_elecx_single();
  }else{
    for(y=[-1,1])
      translate([0,
        y*(n-1)*step/2,
        0])
        dinrail_elecx_single();
  }
  if(dinrail==true){
   dinrail(l=100+step*(n-1));
  }   
}

module dinrail_elecx_single_holes(){
  for(x=[-1,1]){ 
        for(y=[-1,1]){
          translate([x*(dinholder_x+dinrail_w1)/4,
                     y*(dinholder_y-dinrail_lever_w)/2,
                     -foot_h1])
              screw_fix(w=foot_h1*4,
                        d=dinrail_screw,
                        type=head_cnt,
                        t=foot_gap);

        }
      } 
  }

module dinrail_elecx_holes(n=1){
  if(n<din_two_holder){
    dinrail_elecx_single_holes();
  }else{
    for(y=[-1,1])
      translate([0,
        y*(n-1)*step/2,
        0])
        dinrail_elecx_single_holes();
  }   
}

dinrail_elecx(n=n,dinrail=dinrail);

 