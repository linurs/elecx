// Assembly of the elecx 
// Check how the components fit together and animate

// include gets also the definitions
//
include <foot/foot_dim.scad>

// use gets just the modules
use <motherboard/motherboard.scad>
use <pcbmodule/pcbmodule.scad>
use <wall/wall.scad>
use <foot/foot.scad>
use <head/head.scad>
use <dinrail/dinrail_elecx.scad>
use <elecx_screw.scad>

// set animation to 1 to animate otherwise to 0
// In the animation set FPS to 10 and steps to 50
//animation=1; 
animation=0; 

if(animation==1){

  n=floor(6*$t)+1;
  rotate([0,0,-$t*360])
  translate([-foot_x/2,-(foot_min_y+(n-1)*step)/2,0])  
  {      
      motherboard_assembled(n=n);  
      if(($t>0.1)&&($t<0.8))
          color("blue")foot(n=n, type=foot_type_none);
      else 
          color("blue")foot(n=n, type=foot_type_bracket);   
      if(($t>0.2)&&($t<0.8))color("yellow")dinrail_elecx(n=n);     
      if($t>0.3)pcbmodule(n=n);  
      if($t>0.4)color("blue")head(n=n, vent=1, brand=0);
      if($t>0.5)color("blue")walls(n=n, vent=1, brand=0);   
  }
      
}else{
    n=1;
    difference(){
        union(){
         //   motherboard_assembled(n=n,type=1);
          //  pcbmodule(n=n);
         //   
            walls(n=n, vent=1, brand=1);
         //
         //              wall(n=n, vent=1, brand=1);
         // 
            foot(n=n, type=foot_type_none);  
         // 
         //   head(n=n, vent=1, brand=1);
         // dinrail_elecx(n=n);   
            
         // motherboard_screw(n=n, raise=10);
         // wall_head_screw(n=n);
         // wall_head_opposite_screw(n=n);
         // wall_foot_screw(n=n);
         // wall_foot_opposite_screw(n=n); 
        }
        // use % to see where the cubes are and cut
        // %translate([-75,-50,-50]) cube([150,150,150]);
        // %translate([50,15,-50]) cube([150,150,150]);
    }
}
