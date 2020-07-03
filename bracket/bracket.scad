// bracket
// =======
// A bracket of the elecbox module
// - type: 0 front bracket, 1 rear bracket
// - width 1..n in steps

// parameters for customizer
// bracket width
n=2; // [1,2,3,4,5,6,7,8]
// type
bracket="Front"; // [Front,Back]
// intermediate mounting holes
intermediate=false;  

include <../pcb/pcb_dim.scad>

include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>
include <bracket_dim.scad>

use <../library/linurs/linurs_screw.scad>
    
module back_bracket(n=1, intermediate=false){
  mirror([1,0,0])       // mirror it if desired
  front_bracket(n=n, intermediate=intermediate); 
}
    
module front_bracket(n=1, intermediate=false){
  echo("bracket");  
  //color("White")
  intermediatestep=(intermediate)?step:0; 
  difference(){
    union(){
      translate([-bracket_h2/2-bracket_gap/2,
                 bracket_w(n)/2-bracket_w1,
                 bracket_l/2])  
      cube([bracket_h2,
            bracket_w(n),
            bracket_l],center=true); // create the bracket front
  
      translate([bracket_h/2-bracket_h2-bracket_gap/2,
                 bracket_t/2-bracket_w1,
                 bracket_l/2]) 
      cube([bracket_h,
            bracket_t,
            bracket_l],center=true); // U shape side of the screw
      
      translate([bracket_h1/2-bracket_h2-bracket_gap/2,
                 bracket_w(n)-bracket_w1-bracket_t/2,
                 bracket_l/2]) 
      cube([bracket_h1,
            bracket_t,
            bracket_l],center=true); // U shape where no screw  
      for(x=[1:n]){  // create the mounting hole cubes 
        for(z=[bracket_l1,
               bracket_l1+bracket_ld]){
          translate([ bracket_h/2-bracket_h2-bracket_gap/2,
                     -bracket_w1/2+(x-1)*intermediatestep,
                     z])
          cube([bracket_h,
                bracket_w1,
                bracket_l2],center=true);
        }
      }   
    }
    for(x=[1:n]){ // create the mounting hole 
      for(z=[bracket_l1,
             bracket_l1+bracket_ld]){
        translate([bracket_h3-bracket_h2-bracket_gap/2,
                  -bracket_w1/2+(x-1)*intermediatestep,
                   z])
        rotate([0,90,0])
        rotate([-90,0,0])
        screw_fix(w=bracket_w1,d=bracket_screw,type=head_no, t=bracket_screw_gap);
      }
    }
  }
}

if(bracket=="Front"){
  front_bracket(intermediate=intermediate,n=n);
}

if(bracket=="Back"){
  back_bracket(intermediate=intermediate,n=n);
}
