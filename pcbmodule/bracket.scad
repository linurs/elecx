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
bracket(type=1);
//

// to print
//rotate([0,-90,0])bracket(type=0);
//rotate([0,90,0]) bracket(type=1);
//bracket(type=0);

module arduino(){
    difference(){
        bracket(type=0);
        translate([0,1+12/2,52.5+13/2])cube([20,12,13],center=true);
        translate([0,1+12/2,24+10/2])cube([20,12,10],center=true);
        translate([0,1+12+2/2,21.5+54/2])cube([20,2,54],center=true);
    }
}
//rotate([0,-90,0])
//arduino();

module 3DprinterIOfront(){
    difference(){
        bracket(type=0);
        translate([0,11/2,37.5+34/2])cube([20,11,34],center=true);        
    }
}
//rotate([0,-90,0])
//3DprinterIOfront();

module 3DprinterIOback(){
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,14/2,12+31/2])cube([20,14,31],center=true); 
        translate([0,14/2,53.5+18.5/2])cube([20,14,18.5],center=true);               
    }
}
//rotate([0,90,0])
//3DprinterIOback();

module Fetback(){
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,14/2,15+51/2])cube([20,14,51],center=true); 
       
    }
}
//rotate([0,90,0])
//Fetback();

module Stepperback(){
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,14/2,15+14/2])cube([20,14,14],center=true); 
        translate([0,14/2,30+14/2])cube([20,14,14],center=true); 
        translate([0,14/2,45+14/2])cube([20,14,14],center=true); 
        translate([0,14/2,60+14/2])cube([20,14,8],center=true); 
            
    }
}
//rotate([0,90,0])
//Stepperback();

module Stepperfront(){
    difference(){
        bracket(type=0);
        translate([0,14/2,15+14/2])cube([20,14,14],center=true); 
        translate([0,14/2,30+14/2])cube([20,14,14],center=true);    
       translate([0,14/2,60+14/2])cube([20,14,8],center=true);      
    }
}
//rotate([0,-90,0])
//Stepperfront();

module I2Cback(){
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,12/2,31+13/2])cube([20,12,13],center=true);       
    }
}
//rotate([0,90,0])
//I2Cback();

module I2Cfront(){
    difference(){
        bracket(type=0);
        translate([0,13/2,21+25/2])cube([20,13,25],center=true); 
        translate([0,5,49])rotate([0,90,0])cylinder(h=20,d=5.5,center=true, $fn=16);    
        translate([0,5,57])rotate([0,90,0])cylinder(h=20,d=5.5,center=true, $fn=16);      
    }
}
//rotate([0,-90,0])
//I2Cfront();

module MCP2221back(){
    h=12;
    w=13;
    z=31;
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,h/2+pcb_thick,z+w/2])cube([20,h,w],center=true);       
    }
}
//rotate([0,90,0])
//MCP2221back();

module MCP2221front(){
    h1=12;
    w1=12;
    z1=29;
    d2=4;
    h2=3;
    z2=66;
    difference(){
        bracket(type=0);
        translate([0,h1/2+pcb_thick,z1+w1/2])cube([20,h1,w1],center=true); 
        translate([0,h2+pcb_thick,z2])rotate([0,90,0])cylinder(h=20,d=d2,center=true, $fn=16);          
    }
}
//rotate([0,-90,0])
//MCP2221front();