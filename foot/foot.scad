// foot
// ====
// the foot of the elecx

n=2;              // [1,2,3,4,5,6,7,8]
show="default";   // [default,2d,xcut,ycut,print]
foot_type="none"; // [none,default,dinrail,bracket]
vent=false;   
foot_vent_x=1.5;
foot_vent_y=6;
foot_vent_n=11;

include <foot_dim.scad>
include <../library/dinrail/dinrail_holder_dim.scad>
include <../dinrail/dinrail_elecx_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../library/din41612/din41612_female.scad>
use <../dinrail/dinrail_elecx.scad>

module foot(n=1, vent=false, type="none"){
    echo("foot");
    difference(){
        union(){// adding material
            translate([0,0,foot_h1/2])cube([foot_l,foot_w(n),foot_h1],center=true);  // the bottom
         
            for(i=[-1,1]){
               translate([(foot_l-foot_l2)/2*i,0,foot_h/2])
                cube([foot_l2,foot_w(n),foot_h],center=true); //y side walls
            }
            
            for(i=[-1,1]){
               translate([(foot_l-foot_l3)/2*i,0,foot_h3/2])
                cube([foot_l3,foot_w(n),foot_h3],center=true); // bracket floor
            }
            
            for(i=[-1,1]){
               translate([(foot_l-foot_l4)/2*i,
                          (foot_w3(n)-foot_w(n))/2+foot_w4,
                          foot_h4/2])
                cube([foot_l4,foot_w3(n),foot_h4],center=true); // motherboard floor
            }
            
            for(i=[-1,1]){
                for(j=[-1,1]){
                    translate([(foot_l-foot_l5)/2*i,(foot_w(n)-foot_w5)/2*j,foot_h5/2])
                    cube([foot_l5,foot_w5,foot_h5],center=true); // wall stands
                }
            }
            
            for(i=[-1,1]){
               translate([0,(foot_w(n)-foot_w2)/2*i,foot_h/2])
                cube([foot_l,foot_w2,foot_h],center=true); //x side walls
            }
                        
            // add material for foot fixation options 
            if(type=="bracket"){  
                for(i=[-1,1]){
                    for(j=[-1,1]){
                        translate([(foot_l+foot_bracket_x)/2*j,
                                   (foot_w(n)-foot_bracket_y)/2*i,
                                   foot_bracket_t/2])
                        difference(){
                            cube([foot_bracket_x,
                                    foot_bracket_y,
                                    foot_bracket_t],center=true);
                            cylinder(h=2*foot_bracket_t,d=foot_bracket_d, center=true,$fn=16);
                        }  
                        translate([foot_l/2*j,
                                   (foot_w(n)-foot_bracket_y)/2*i,
                                   foot_bracket_t/2])
                        rotate([0,-90,90])
                        cylinder(h=foot_bracket_y,d=foot_bracket_enforce_d, center=true, $fn=3);   
                    }
                }
            }
    }// removing material
    
       translate([0,0,foot_h2+foot_h1/2])cube([foot_l1,foot_w1(n),foot_h1],center=true);  // at the bottom
    
       for(i=[1:n*2-1]){ // add the holes every step and between
           for(j=[-1,1]){
            translate([din41612_female_dl/2*j,
                       -foot_w(n)/2+step/2*(i-1)+foot_w4+din41612_female_w/2,
                       foot_h4-foot_dh/2])
              screw_fix(w=foot_dh,
              d=M2_5,
              type=head_no, 
              t=foot_gap,
              nut_sink=foot_h4-foot_dh);
           }
       }
       
       for(i=[-1,1]){ // add holes for the wall
           for(j=[-1,1]){
               translate([wall_ld/2*j,
                       (foot_w(n)/2-foot_w2-wall_hd2)*i,
                       foot_h5/2]) 
              rotate([0,180,0]) 
              screw(w=foot_h5+0.1,
              d=M3,
              type=head_cnt, 
              t=foot_gap);
           }
       }    
        
    if(type=="dinrail"){  // holes for din holder
      echo("dinrail",dinholder_x,dinrail_w1);  
      echo(two_holder(n));  
      dinrail_elecx_holes(n=n);   
    }
  
    if(vent==true){
         for(j=[0:foot_vent_n]){
             x=(foot_l-foot_l1)/2-foot_l/2+foot_vent_x/2 + j*(foot_l1-foot_vent_x)/foot_vent_n;
             echo(j,x);
             for(i=[0:n-1]){
               y=i*step-(n-1)*step/2;  
               translate([x,y,0])
                cube([foot_vent_x,
                       step-foot_vent_y,
                       2*foot_h1],center=true);
            }
          }
        }
  }  
}    

if(show=="default"){
    foot(n=n, type=foot_type, vent=vent);
}

if(show=="print"){
   foot(n=n, type=foot_type, vent=vent);
}

if(show=="2d"){
    rotate([0,0,0])
    translate([-51,-21.5,14]) 
    foot(n=n, type=foot_type, vent=vent);
}

if(show=="xcut"){
  difference(){ 
    rotate([0,0,0])
      translate([-51,-21.5,14]) 
      foot(n=n, type=foot_type, vent=vent);
    translate([-100,0,-50])
      cube([200,100,100]);  
  }    
}

if(show=="ycut"){
  difference(){ 
    rotate([0,0,0])
      translate([-51,-21.5,14]) 
      foot(n=n, type=foot_type, vent=vent);
    translate([-100,-100,-50])
      cube([100,200,100]);  
  }    
}
