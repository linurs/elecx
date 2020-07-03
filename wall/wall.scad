// Wall
// ====

// Parameters for customizer
// view to the wall
show="2d"; //["2d","print"]
// ventilation slots
vent=true;  
// branding text
brand=true;

include <wall_dim.scad>
include <../elecx_dim.scad>

use <../library/linurs/linurs_screw.scad>

module wall(vent=false, brand=false){
  echo("wall");  
//  color("Blue")
  difference(){
    // add material  
    union(){   
      // the two front pieces  
      for(i=[-1,1]){  
        translate([i*(wall_l+wall_l2)/4,
                   0,
                   0])
        cube([(module_l-module_l1)/2,wall_h,module_h],center=true);
      }
      // the side wall
      translate([0,
                 (wall_h-wall_h2)/2,
                 0])
      cube([wall_l,wall_h2,module_h],center=true); 
      // foot fixation cube
      translate([0,
                 0,
                 (module_h-wall_w5)/2+wall_w1])
      cube([wall_l1,wall_h,wall_w5],center=true); 
      // head fixation cube
      translate([0,
                 (wall_h-wall_h1)/2,
                 -(module_h-wall_w3)/2+wall_w2])
      cube([wall_l5,wall_h1,wall_w3],center=true); 
    }
// take away material 
    // head screw
    translate([0,
               wall_h/2-wall_hd1,
               wall_w2+(wall_w3-module_h)/2])
    screw(w=wall_w3+0.1,d=wall_d1,type=head_cnt, t=wall_screw_gap);
    // foot screws
    for(i=[-1,1]){ 
        translate([i*wall_ld/2,
                   wall_h/2-wall_hd2,
                   module_h/2+wall_w1/2])rotate([0,0,90])
        nut_cut(w=wall_w1*3, wi=0, d=wall_d2, i=10, t=0,  rot=true, type=head_cyl);
    } 
    // cut the foot fixation cube in two
    translate([0,
               -wall_h3,
               (module_h-wall_w5)/2+wall_w1])
    cube([wall_l3,wall_h,wall_w5+0.1],center=true); 
    // make wall thinner
   translate([0,
              -wall_h3,
              0])
   cube([wall_l4,wall_h,wall_w4],center=true); 
   // branding
    if(brand==true){  
         rotate([90,180,180])
         linear_extrude(height = wall_h ) {
         text(branding, 
             font = "Liberation Sans:style=Bold Italic",
             halign = "center",
             valign = "center",
             size=10);
         }
    }
    // ventillation
    if(vent==true){
      for(k=[0:(wall_vent_n-1)/2]){
          for(j=[-1,1]){
              for(i=[-1,1]){
                translate([j*(k*wall_vent_x2+wall_vent_x2/2),
                           wall_h/2,
                           i*(wall_wv1+wall_wv2)/2])  
                cube([wall_vent_x,wall_h,wall_wv1],center=true); 
              }
          }     
      }
    }
  }
}

if(show=="2d"){
  wall(vent=vent, brand=brand);
} 

if(show=="print"){
  rotate([-90,0,0])wall(vent=vent, brand=brand);
} 
