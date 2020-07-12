// din41612 female connector
// =========================

include <din41612_female_dim.scad>

use <../linurs/linurs_screw.scad>

type=true;
// type=true as it is
// type=false upper part removed to not conflict with male connector 
module din41612_female(type=0){ 
   // color("LightGrey")
  difference(){
    union(){
      if(type==true){  
        translate([0,0,din41612_female_h/2])
          cube([din41612_female_l1,
              din41612_female_w1,
              din41612_female_h],
              center=true);  // upper part down to board level
      }    
      translate([0,0,din41612_female_h1/2])
        cube([din41612_female_l,
              din41612_female_w,
              din41612_female_h1],
              center=true); // lower part laying on the board  

    }
    for(i=[-1,1]){ // mounting holes
      translate([i*din41612_female_dl/2,
                 0, 
                 din41612_female_h1/2])
      screw(w=din41612_female_h1+0.1, 
            d=M2_5, 
            type=head_cyl, 
            t=1);
    }
  }
}

din41612_female(type=type);  
