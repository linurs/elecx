// din41612 male connector
// =======================

include <din41612_male_dim.scad>

use <../linurs/linurs_screw.scad>

module din41612_male(){ 
  // color("LightGrey")
  difference(){
    union(){
        translate([0,din41612_male_w1/2,din41612_male_h/2-din41612_male_h1])  
        cube([din41612_male_l1,
              din41612_male_w1,
              din41612_male_h],
             center=true);  
      translate([0,(din41612_male_w1-din41612_male_w)/2,(din41612_male_h-din41612_male_h1)/2]) 
        cube([din41612_male_l1,
              (din41612_male_w-din41612_male_w1),
              din41612_male_h-din41612_male_h1],
             center=true);  
      translate([0,din41612_male_w2/2+din41612_male_w1-din41612_male_w,din41612_male_h2/2])
        cube([din41612_male_l,
              din41612_male_w2,
              din41612_male_h2],
             center=true);  
    }
    for(i=[-1,1]){ // mounting holes
      translate([i*din41612_male_dl/2,
                 din41612_male_w1-din41612_male_w+din41612_male_w2/2, 
                 din41612_male_h1])
      rotate([180,0,90])screw_fix(
            w=din41612_male_h2, 
            d=M2_5, 
            type=head_cyl, 
            nut_sink=din41612_male_h,
            t=0);
    }
  }
}
din41612_male();  