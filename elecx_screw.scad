// Screws for ElecX
include <motherboard/motherboard_dim.scad>
include <library/linurs/linurs_screw_dim.scad>
include <foot/foot_dim.scad>
include <head/head_dim.scad>

use <library/linurs/linurs_screw.scad>
use <motherboard/motherboard.scad>
use <foot/foot.scad>
use <wall/wall.scad>
use <head/head.scad>

screw_motherboard_d=M2_5;
screw_motherboard_l=16;

wall_screw=M3;
screw_wall_foot_l=16; 
screw_wall_head_l=12; 

module motherboard_screw(n=1,t=0, raise=0){
  echo("motherboard screw");  
    for(i=[1:n*2-1]){ // add the holes
      for(j=[-1,1]){
        if(i%2==0){  
            translate([(j*motherboard_con_d_w+motherboard_w)/2,
                        step/2*(i-1)+motherboard_con_t/2,
             -pcbmodule_con_out-screw_motherboard_l/2])
            screw_fix(w=screw_motherboard_l,d=screw_motherboard_d,type=head_cyl, t=t, raise=raise);
        }else{
            translate([(j*motherboard_con_d_w+motherboard_w)/2,
                       step/2*(i-1)+motherboard_con_t/2,
                        
                       -pcbmodule_con_out-screw_motherboard_l/2])
            screw_fix(w=screw_motherboard_l,d=screw_motherboard_d,type=head_cyl, t=t, raise=raise);
        }    
      }
    }
}

module wall_foot_screw(t=0,raise=0){
    wall_fix_p=(foot_step1+foot_step)/2;
    translate([0,
             0,
             bracket_offset_z])
    for(i=[(motherboard_w-motherboard_con_d_w)/2,
              motherboard_w-(motherboard_w-motherboard_con_d_w)/2]){   
                     translate([i,
                 (wall_t-wall_fix_y)/2,                
                  foot_step1-foot_step-wall_fix_p])
  
    rotate([0,180,-90])
    nut_cut(d=wall_screw,
            w=screw_wall_foot_l,
           //   w=foot_step*4, 
            wi=screw_wall_foot_l/2-(foot_z-foot_step),      
            i=wall_fix_y/2,
            t=screw_t,
            type=head_cnt, 
            raise=foot_z/2);     
    }
}

module wall_foot_opposite_screw(t=0,raise=0){
wall_mirror_offset_y=step+2*(-wall_fix_y+wall_y);    
translate([0,wall_mirror_offset_y+(n-1)*step,0])
  mirror([0,1,0])wall_foot_screw();
}

module wall_head_screw(t=0){  
    translate([motherboard_w/2,
               (wall_t-wall_fix_y)/2,
                pcb_h+wall_head_fix_h/2])
    rotate([0,180,-90])
    nut_cut(d=wall_screw,
            w=screw_wall_head_l,
            wi=screw_wall_head_l/2-(head_z-head_side_wall_stand)/2-wall_head_fix_h,      
            i=wall_fix_y,
            t=screw_t,
            type=head_cnt);     
    
}

module wall_head_opposite_screw(t=0){
wall_mirror_offset_y=step+2*(-wall_fix_y+wall_y);    
translate([0,wall_mirror_offset_y+(n-1)*step,0])
  mirror([0,1,0])wall_head_screw();
}

n=1;

//
motherboard_screw(n=n, raise=10);
//%motherboard_assembled(n=n, type=0);

//
wall_head_screw();
//
wall_head_opposite_screw();
//
wall_foot_screw();
//
wall_foot_opposite_screw();
//
%foot(n=n);
//%wall(n=n);
//%walls(n=n);
//%head(n=n);


