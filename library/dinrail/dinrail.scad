// din rail

include <dinrail_dim.scad>
use <../linurs/linurs_body.scad>

l=100;

module dinrail(l=100)
{   
  translate([0,0,dinrail_t/2])
    cube([dinrail_w2-2*dinrail_r-2*dinrail_t,
          l,
          dinrail_t],center=true);
          
  for(i=[-1,1]){
    translate([i*(dinrail_w2-dinrail_t)/2,
               0,
               dinrail_h/2])
      cube([dinrail_t,l,dinrail_h-2*dinrail_r-2*dinrail_t],
           center=true);  
      
    translate([i*(dinrail_w2/2+(dinrail_w1-dinrail_w2)/4+dinrail_r/2),
               0,
               dinrail_h-dinrail_t/2])
      cube([(dinrail_w1-dinrail_w2)/2-dinrail_r,l,dinrail_t],
           center=true);
      
    translate([i*(-dinrail_w2/2+dinrail_r+dinrail_t),
               0,
               dinrail_r+dinrail_t])
      rotate([90,90+i*45,0])  
      channel(d1=dinrail_r*2,d2=(dinrail_r+dinrail_t)*2,h=l,a=90);  
      
    translate([i*(-dinrail_w2/2-dinrail_r),
               0,
               dinrail_h-dinrail_r-dinrail_t])
      rotate([90,-90+i*45,0])  
      channel(d1=dinrail_r*2,d2=(dinrail_r+dinrail_t)*2,h=l,a=90);       
  }
}

dinrail(l=l);

