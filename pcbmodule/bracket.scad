// bracket
// A bracket of the elecbox module
// - type: 0 front bracket, 1 rear bracket
// - width 1..n in steps
// - var: 0 do not create intermediate mounting holes, 1 create intermediate mounting holes 

include <pcbmodule_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>


module bracket(type=0, width=1, var=0){
  echo("bracket");  
  color("White")
  translate([type*motherboard_w,
             0,
             0])  // move mirrored bracket in position if desired
  mirror([type*1,0,0])       // mirror it if desired
  difference(){
    union(){
      for(x=[1:width]){  // create the mounting hole cubes 
        for(z=[pcb_y1,pcb_y2]){
          translate([pcb_x1,
                     (x-1)*step*var-bracket_hole_cube_h/2,
                     z])
          cube([bracket_x1-bracket_t,bracket_hole_cube_h,3*screw_d[bracket_screw]],center=true);
        }
      }

      translate([bracket_t/2+bracket_offset_x,
                 step/2*width-bracket_hole_cube_h,
                 bracket_h/2+bracket_offset_z])  
      cube([bracket_t,step*width,bracket_h],center=true);  // create the bracket front


      translate([bracket_x1/2+bracket_offset_x,
                 bracket_t/2-bracket_hole_cube_h,
                 bracket_h/2+bracket_offset_z]) 
      cube([bracket_x1,bracket_t,bracket_h],center=true);  // create the bracket mounting


      translate([bracket_x2/2+bracket_offset_x,
                 bracket_t/2-bracket_hole_cube_h+step*width-bracket_t,
                 bracket_h/2+bracket_offset_z]) 
      cube([bracket_x2,bracket_t,bracket_h],center=true);  // create the bracket mounting


    }
    for(x=[1:width]){ // create the mounting hole 
      for(z=[pcb_y1,pcb_y2]){
        translate([pcb_x1,
                   (x-1)*step*var-olp,
                   z])
        rotate([0,90,0])
        rotate([-90,0,0])
        screw_fix(w=2*bracket_hole_cube_h,d=bracket_screw,type=head_no, t=screw_t);
      }
    }
  }
}

// to show
//bracket(type=1, width=2, var=1);
//
bracket();
//
bracket(type=1);
