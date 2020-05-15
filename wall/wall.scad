// walls
// walls of the elecx
include <wall_dim.scad>
include <../elecx_dim.scad>
include <../pcbmodule/pcbmodule_dim.scad>
include <../foot/foot_dim.scad>
include <../head/head_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_body.scad>
use <../head/head.scad>
use <../foot/foot.scad>
use <../library/linurs/linurs_screw.scad>
use <../elecx_screw.scad>

wall_vent_x=1.5;
wall_vent_n=20;
wall_vent_z=20;
wall_vent_gap=6;
wall_vent_open_z=(pcb_h-foot_side_wall_h-bracket_offset_z-wall_vent_z-2*wall_vent_gap)/2;
wall_brand_z=3;
wall_ys=1;

wall_s=(motherboard_w-wall_vent_x)/(wall_vent_n-1);
wall_fix_p=(foot_step1+foot_step)/2;

module wall(vent=0, brand=1, mir=0){
  echo("wall");  
//  color("Blue")
  translate([0,
             0,
             bracket_offset_z])
  difference(){
    union(){
// add material    
      // the two front pieces  
      for(i=[0:1]){  
        translate([bracket_offset_x+i*(pcbmodule_w-bracket_x2),
                   -bracket_hole_cube_h-wall_y,
                   0])
        cube([bracket_x2,wall_y,bracket_h]);
      }
      
      // the side wall
      translate([bracket_offset_x,
                 -bracket_hole_cube_h-wall_y,
                 0])
       cube([pcbmodule_w,wall_t,bracket_h]); 
      
      // foot fixation cube
      translate([0,
                   -bracket_hole_cube_h-wall_y,
                 -foot_step1-wall_fix_p])
      cube([motherboard_w,wall_y,foot_step1+wall_fix_y]); 
  
      // head fixation cube
      translate([(motherboard_w-head_groove_access_x)/2,
                 -wall_fix_y,
                 2*pcb_h-2*bracket_offset_z-bracket_h])
      cube([head_groove_access_x,wall_fix_y-pass_t,wall_head_fix_h]); 
    }
    
// take away material 
    translate([0,
               0,
               -bracket_offset_z]){
      wall_foot_screw(t=screw_t);
      wall_head_screw(t=screw_t);
    }         
    // cut the foot fixation cube in two
    translate([(motherboard_w-wall_gap_x)/2,
   //            wall_t
               wall_ys-bracket_hole_cube_h-wall_y,
              -foot_step-olp-wall_fix_p])
    cube([wall_gap_x,
           wall_fix_y-wall_t+olp,
           foot_step+wall_fix_y+2*olp]); 


   translate([bracket_offset_x+10,
              -bracket_hole_cube_h-wall_y+wall_ys,
                 +10])
   cube([pcbmodule_w-20,
         wall_t,
         bracket_h-20]); 
    
    // branding
    if(brand==1){  
         translate([(motherboard_w)/2-mir*(motherboard_w)/2+mir*(motherboard_w)/2,
                  (mir*-1)*motherboard_w/2,
                  bracket_h/2])
         rotate([90,0,mir*180])
         linear_extrude(height = motherboard_w ) {
         text(branding, 
             font = "Liberation Sans:style=Bold Italic",
             halign = "center",
             valign = "center",
             size=10);
         }
    }

    if(vent==1){
      for(j=[0:wall_vent_n-1]){
        for(i=[foot_side_wall_h+wall_vent_gap,
               foot_side_wall_h+wall_vent_gap+wall_vent_open_z+wall_vent_z]){

          translate([j*wall_s, 
                     -wall_fix_y-wall_t-olp,
                     i])
          cube([wall_vent_x,
                wall_t+2*olp+20,
                wall_vent_open_z]);
        }
      }
    }
  }
}

module wall_opposite(n=1, vent=0, brand=0){
  translate([0,n*step-bracket_hole_cube_h,0])
  mirror([0,1,0])
  translate([0,bracket_hole_cube_h,0])  
  wall(vent=vent, brand=brand, mir=1);
}

module walls(n=1, vent=0, brand=1){
  wall(vent=vent, brand=brand);
  wall_opposite(n=n, vent=vent, brand=brand);
}

// To see
// ======
//walls( brand=0, vent=1);
//wall(vent=1, brand=1);
//wall_opposite(vent=1, brand=1, n=4);
//%head();
//%foot();

// To print
// ========
//
rotate([90,0,0])
//
wall(vent=1, brand=1);
