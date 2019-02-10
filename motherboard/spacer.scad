// spacer for connectors when not having a motherboard
include <motherboard_dim.scad>
w=0.6;
s=2.54;
translate([-(3*s)/2-w/2,-(32*s+w)/2,-motherboard_t/2]){
        for(i=[0:3]){
        translate([i*s,0,0])
        cube([w,32*s+w,motherboard_t]);
    }    
}
for(i=[-1,1]){ // mounting holes
      translate([0,i*motherboard_con_d_w/2,0])difference(){
          cube([3*s+w,8.5,motherboard_t],center=true);
          cylinder(d=motherboard_con_d,h=motherboard_con_h,center=true,$fn=16); 
      }
}