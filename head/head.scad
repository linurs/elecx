//head
// the head of the elecx

include <../elecx_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../foot/foot_dim.scad>
include <head_dim.scad>

use <../library/linurs/linurs_body.scad>
use <../library/linurs/linurs_screw.scad>
use <../elecx_screw.scad>
use <../wall/wall.scad>

head_bracket_x=30;
head_bracket_undercut_z=2;
head_vent_x=1.5;
head_vent_y=2;
head_vent_n=5;
head_vent_start1=(motherboard_w-2*bracket_offset_x)/2+bracket_offset_x-head_bracket_x-head_groove_access_x/2;
head_vent_stop1=(motherboard_w-head_groove_access_x)/2-head_vent_x;
head_vent_start2=(motherboard_w+head_groove_access_x)/2;
head_vent_stop2=(motherboard_w-2*bracket_offset_x)/2+bracket_offset_x+head_groove_access_x/2+head_bracket_x-head_vent_x;
head_brand_y=1;
head_undercut_x=(motherboard_w-2*bracket_offset_x-head_groove_access_x-2*head_bracket_x)/2;

module head(n=1,vent=0, brand=0){
    echo("headnew");
    head_y=foot_min_y+(n-1)*step;
    difference(){
        translate([foot_offset_x,
                   foot_offset_y,
                   pcb_h+head_z]) 
        union(){// adding material
            translate([-pass_t,-pass_t,0])
            cube([foot_x+2*pass_t,
                  head_y+2*pass_t,
                  head_t]);  // head top
            
            for(i=[-pass_t,head_y-foot_side_wall_t+pass_t]){
                        translate([-pass_t,i,-head_z])
                        cube([foot_x+2*pass_t,
                              foot_side_wall_t,
                              head_z]); // y side walls
            }
                    
            foot_x_offset_wall=foot_x-foot_side_wall_t;
            for(i=[-pass_t,foot_x_offset_wall+pass_t]){
                        translate([i,-pass_t,-head_z])
                        cube([foot_side_wall_t,
                              head_y+2*pass_t,
                              head_z]); // x side walls
            }     
    
            for(i=[foot_side_wall_t,
                   foot_min_y+(n-1)*step-wall_t-foot_side_wall_t]){ 
                translate([foot_side_wall_t,
                           i-pass_t/2,
                           -head_side_wall_stand])
                cube([motherboard_w-2*bracket_offset_x+2*olp+pass_t,
                      wall_t+pass_t,
                      head_side_wall_stand]);// side wall stand
            }
            
            head_bracket_stand=head_z-(bracket_h-pcb_h+bracket_offset_z);            
            for(i=[foot_side_wall_t,
                    motherboard_w-2*bracket_offset_x-foot_side_wall_t]){
                translate([i-pass_t/2,
                           foot_side_wall_t,
                           -head_bracket_stand])                
                        
                cube([bracket_t+olp+pass_t,
                      2*wall_y+n*step+pass_t,
                      head_bracket_stand]);  // bracket stand
            }
            
            for(i=[0,
                   head_y-wall_fix_y-wall_t-foot_side_wall_t]){
                translate([(foot_x-head_groove_access_x)/2,
                           i,
                           -head_bracket_stand])                
                        
                cube([head_groove_access_x,
                      wall_fix_y+wall_t+foot_side_wall_t,
                      head_bracket_stand]);  // wall fixation cube up to braket stand
            }
            for(i=[foot_side_wall_t+wall_t,
                   head_y-wall_fix_y-foot_side_wall_t-wall_t]){
                translate([(foot_x-head_groove_access_x)/2,
                           i,
                           -head_z])                
                        
                cube([head_groove_access_x,
                      wall_fix_y,
                      head_z]);  // wall fixation cube up to head
            }
            
        }// removing material 
        wall_head_screw(t=screw_t, n=n);  
        wall_head_opposite_screw(t=screw_t,n=n);  
                
        if(vent==1){
          for(j=[0:head_vent_n]){
             for(i=[0:n-1]){
               translate([
                         (head_vent_stop1-head_vent_start1)/head_vent_n*j+head_vent_start1,
                         (foot_min_y-step)/2+foot_offset_y+i*step+head_vent_y/2,
                         head_z+pcb_h-head_t/2])
                cube([head_vent_x,
                       step-head_vent_y,
                       2*head_t]);
            }
          }
          for(j=[0:head_vent_n]){
            for(i=[0:n-1]){
               translate([
                         (head_vent_stop2-head_vent_start2)/head_vent_n*j+head_vent_start2,
                         (foot_min_y-step)/2+foot_offset_y+i*step+head_vent_y/2,
                         head_z+pcb_h-head_t/2])
               cube([head_vent_x,
                      step-head_vent_y,
                      2*head_t]);
            }
          }
        }
        
        if(brand==1){         
         translate([
           (motherboard_w-2*bracket_offset_x+2*foot_side_wall_t)/2+bracket_offset_x-foot_side_wall_t,
           (foot_min_y+(n-1)*step)/2+foot_offset_y,
           head_z/2])
         rotate([0,0,90])
         linear_extrude(height = motherboard_w ) {
         text(branding, 
             font = "Liberation Sans:style=Bold Italic",
             halign = "center",
             valign = "center",
             size=10);
         }
        }        
    }        
}

n=5;//%walls(n=n);
//%wall();
//%head(n=n, vent=1, brand=1);
//%bracket();
//%bracket(type=1);
//pcb();

//to print
//
rotate([180,0,0])
//
head(n=n, vent=1, brand=1);
