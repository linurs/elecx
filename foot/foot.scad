//foot
include <../elecx_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../pcbmodule/pcbmodule_dim.scad>
include <../library/dinrail/dinrail_holder_dim.scad>
include <foot_dim.scad>

use <../library/linurs/linurs_body.scad>
use <../wall/wall.scad>
use <../pcbmodule/pcbmodule.scad>
use <../elecx_screw.scad>
use <../motherboard/motherboard.scad>
use <../dinrail/dinrail_elecx.scad>

foot_vent_x=1.5;
foot_vent_y=6;
foot_vent_n=11;

foot_vent_start=foot_x/2-30+foot_offset_x;
foot_vent_stop =foot_x/2+30+foot_offset_x;

module foot(n=1, vent=0, type=foot_type_none){
    echo("footnew");
    foot_y=foot_min_y+(n-1)*step;
    echo(foot_y);
    difference(){
        union(){// adding material
            translate([foot_offset_x,
                   foot_offset_y,
                   foot_offset_z]){
            cube([foot_x,
                  foot_y,
                  foot_bottom_t]);  // the bottom
            
            for(i=[-pass_t,foot_y-foot_side_wall_t+pass_t]){
                translate([-pass_t,i,0])
                cube([foot_x+2*pass_t,
                      foot_side_wall_t,
                      foot_outer_z]); // y side walls
            }
            
            foot_x_offset_wall=foot_x-foot_side_wall_t;
            for(i=[-pass_t,foot_x_offset_wall+pass_t]){
                translate([i,-pass_t,0])
                cube([foot_side_wall_t,
                      foot_y+2*pass_t,
                      foot_outer_z]); // x side walls
            }
            
            foot_x_offset_bracket=foot_x_offset_wall-bracket_t;
            foot_x_bracket=bracket_t+foot_side_wall_t;
            for(i=[0,foot_x_offset_bracket]){
                translate([i,0,0])
                cube([foot_x_bracket,
                      foot_y,
                      foot_z]); // bracket floor
            }
            
            foot_x_offset_motherboard=foot_x_offset_wall-bracket_t-foot_motherboard_f;
            foot_x_motherboard=bracket_t+foot_side_wall_t+foot_motherboard_f;
            for(i=[0,foot_x_offset_motherboard]){
                translate([i,(foot_y-(motherboard_con_t+step*(n-1)))/2,0])
                cube([foot_x_motherboard,
                      motherboard_con_t+step*(n-1),
                      foot_z-foot_step]); // motherboard floor
            }
            
            foot_nut=10;
            foot_x_offset_nut=foot_x_offset_wall-bracket_t-foot_nut;
            foot_x_nut=bracket_t+foot_side_wall_t+foot_nut;
            for(i=[0,foot_x_offset_nut]){
                translate([i,0,0])
                cube([foot_x_nut,
                      foot_y,
                      3]); // motherboard floor
            }
              foot_x_wallmount=(motherboard_w-wall_gap_x)/2+foot_side_wall_t+foot_x_bracket;
            foot_x_offset_wallmount=foot_x-foot_x_wallmount;
            foot_y_offset_wallmount=foot_y-wall_fix_y;   
            for(j=[0,foot_y_offset_wallmount]){
                for(i=[0,foot_x_offset_wallmount]){
                    translate([i,j,0])
                    cube([foot_x_wallmount,
                          wall_fix_y,
                    foot_z-foot_step-foot_step1]); // wall mount floor                      
                }
            }
            // add material for foot fixation options 
            if(type==foot_type_bracket){  
              for(i=[foot_bracket_y/2,foot_bracket_y/2+foot_min_y-foot_bracket_y+(n-1)*step]){    
                for(j=[-foot_bracket_x/2,
                       motherboard_w+2*foot_side_wall_t-2*bracket_offset_x+foot_bracket_x/2]){                
                  translate([j,i,foot_bracket_t/2])
                    difference(){  // the brackets
                      cube([foot_bracket_x,
                            foot_bracket_y,
                            foot_bracket_t],center=true);
                      cylinder(h=foot_bracket_t+olp,d=foot_bracket_d, center=true,$fn=16);  
                    }
                }
                for(j=[0,
                       motherboard_w+2*foot_side_wall_t-2*bracket_offset_x]){
                           translate([j,i,foot_bracket_t/2+foot_bracket_t/2])
                  rotate([0,-90,90])
                   cylinder(h=foot_bracket_y,d=foot_bracket_enforce_d, center=true, $fn=3);  // enforcement of the brackets
                }
              }// mounting brackets
            }
            
        }
    }// removing material
    motherboard_screw(n=n,t=screw_t, raise=foot_outer_z/2);
    wall_foot_screw(t=screw_t);
    wall_foot_opposite_screw(n=n,t=screw_t);
    if(type==foot_type_dinrail){  // holes for din holder
           dinrail_elecx(n=n, type=1);
    }
    
    if(vent==1){
          z=foot_offset_z-foot_bottom_t;
          for(j=[0:foot_vent_n]){
             x=(foot_vent_stop-foot_vent_start)/foot_vent_n*j+foot_vent_start;
             for(i=[0:n-1]){
               y=(foot_min_y-step)/2+foot_offset_y+i*step+foot_vent_y/2;  
               translate([x,y,z])
                cube([foot_vent_x,
                       step-foot_vent_y,
                       3*foot_bottom_t]);
            }
          }
        }
  }  
}    

n=5;
//walls(n=n);
//
//pcbmodule(n=n);
//wall();
//walls();

//to print
//foot(n=n, type=foot_type_none);
//translate([0,150,0])
//
foot(n=n, type=foot_type_dinrail, vent=1);
//translate([0,300,0])
//foot(n=n, type=foot_type_bracket);
//motherboard_assembled(n=n, type=0);
