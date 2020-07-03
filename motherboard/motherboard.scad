// Motherboard of the elecbox
// ==========================

n=2; // [1,2,3,4,5,6,7,8]
motherboard_assembly=true;

include <motherboard_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../library/din41612/din41612_female.scad>

module motherboard(n=1){
  echo("motherboard");  
  difference(){ 
    cube([motherboard_l,
          motherboard_w(n),// din41612_female_w+step*(n-1),
          motherboard_h]); // the pcb
    motherboard_screw(n=n,t=motherboard_pass); // the holes
  }
}

module motherboard_assembly(n=1){
  echo("motherboard assembly");  
  motherboard(n=n);
  for(i=[0:n-1]){ // add the connectors
      translate([motherboard_l/2,din41612_female_w/2+step*i,motherboard_h])
      din41612_female();
  }    
}

module motherboard_screw(n=1,t=0, raise=0){
  echo("motherboard screw");  
  for(i=[1:n*2-1]){ // add the holes every step and between
    for(j=[-1,1]){
      if(i%2==0){  // where no connector
        translate([(j*din41612_female_dl+motherboard_l)/2,
                   step/2*(i-1)+din41612_female_w/2,
                   0])
          screw_fix(w=screw_motherboard_l,
          d=screw_motherboard_d,
          type=head_cyl, 
          t=t);
      }else{ // where connector
        translate([(j*din41612_female_dl+motherboard_l)/2,
                   step/2*(i-1)+din41612_female_w/2, 
                   0])
          screw_fix(w=screw_motherboard_l,
                    d=screw_motherboard_d,
                    type=head_cyl, 
                    t=t);               
      }    
    }
  }
}

if(motherboard_assembly==true){
  motherboard_assembly(n=n);
}else{
    // Move to center to create 2D drawings from top view 
    // with script OpenSCAD22d.py
    translate([-motherboard_l/2,
               -(din41612_female_w+step*(n-1))/2, 
               -motherboard_h/2])
    motherboard(n=n);
}