// Support to store modules
// ========================
//

// Parameters for customizer
show="support"; //["support","wedge"]

include <../library/linurs/linurs_screw_dim.scad>

use <../module/empty.scad>
use <../library/linurs/linurs_screw.scad>

module wedge(){
    for(i=[-1,1]){
      translate([i*l1/2,0,-0.005])cylinder(d1=d1-pass,d2=d2-pass,h=h+0.01,$fn=32);
      translate([0,0,-0.005])
      rotate([0,-90,0])  
      linear_extrude(height=l1, center = true){
             polygon(points=[
                        [0,           (-y1+pass)/2],
                        [0,            (y1-pass)/2],
                        [h+0.01,       (y2-pass)/2],
                        [h+0.01,      (-y2+pass)/2],
                        ], paths=[[0,1,2,3]]);
            }  
    }    
}

module block(){
    difference(){
        translate([-5,-step/2,0])cube([l,step,h]);
        translate([-5,0,0])wedge();
        for(i=[-1,1]){
          translate([5,i*step/2,0])rotate([0,0,90])wedge(); 
          translate([0,i*step/4,h/2+0.005]) //cylinder(h=20,d=4,$fn=32,center=true);    
            screw(w=h+0.1,d=M3,type=head_cnt, t=0.5);
        }    
    }
translate([12.8,-y/2,0])cube([x,y,h]);

}

module support(){
    difference(){
        union(){
            translate([-12.5,8.5,-11])block();
            translate([112.5,8.5,-11])rotate([0,0,180])block();
            for(i=[0,step-y3]){
            translate([-2.5,i-4.2,-11])cube([105,y3,1]);
            }    
            translate([-2.5+105/2-y3/2,-step/2+8.5,-11])cube([y3,step,1]);
            
            translate([-2.5+105/2,8.5,-11])
                cylinder(d=8,h=h-1,$fn=32);
           
        }    
        translate([-2.5+105/2,8.5,-11+(h-1)/2+0.005])
          //   cylinder(d=4,h=2*h,$fn=32);
        screw(w=h-1+0.1,d=M3,type=head_cnt, t=0.5);
    }
}

d1=6;
d2=4;
h=5;
l=15;
l1=10;
y1=3;
y2=1.5;
step=25.4;
y=step-5;
x=3;
y3=5;
pass=0.5;

if(show=="support"){
  empty_assembly();
  support();
}

if(show=="wedge"){
  translate([0,50,0])wedge();
}    