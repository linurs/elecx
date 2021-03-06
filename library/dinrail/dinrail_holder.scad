// din holder
include <dinrail_dim.scad> 
include <../linurs/linurs_screw_dim.scad>
include <dinrail_holder_dim.scad>

use <dinrail.scad>
use <../linurs/linurs_screw.scad>
use <../linurs/linurs_body.scad>

show="assembly"; // [assembly,dinrail_bracket,dinrail_lever_holder,dinrail_lever,print_dinrail_bracket,print_dinrail_lever_holder]
dinholder_x=100;
s=2;
n=2;
t=0;

module dinrail_screw(dinholder_x=100,t=0){
    echo("dinrailscrews",dinholder_x,dinrail_w1);  
    for(x=[-1,1]){ 
        for(y=[-1,1]){
          translate([x*(dinholder_x+dinrail_w1)/4,
                     y*(dinholder_y-dinrail_lever_w)/2,
                     dinholder_bracket_z+dinrail_h])
          if(x==1){
              translate([0,0,-dinrail_screw_l1/2])
              screw_fix(w=dinrail_screw_l1+0.01,
                        d=dinrail_screw,
                        type=head_no,
                        t=t);
          }else{
             translate([0,0,-dinrail_screw_l2/2]) 
             screw_fix(w=dinrail_screw_l2+0.01,
                    d=dinrail_screw,
                    type=head_no,
                    t=t);
          }    
        }
    }
}    

module dinrail_bracket(dinholder_x=100){
  echo("dinrail bracket");  
  difference(){
    union(){  
      translate([0,0,dinholder_bracket_z/2+dinrail_h])
        cube([dinholder_x,dinholder_y,dinholder_bracket_z],center=true); //top
    
      translate([-(dinrail_w1+dinholder_x)/4,
                 0,
                 dinrail_h-(dinholder_lever_cover+dinholder_fix_z)/2])
        cube([(dinholder_x-dinrail_w1)/2,
              dinholder_y,
              dinholder_fix_z+dinholder_lever_cover],center=true);  // fix part  
        
      translate([-dinrail_w1/2,
             -dinholder_y/2,
             dinrail_h-dinrail_t])
      rotate([0,90,90])
        linear_extrude(height=dinholder_y){
          polygon(
          points=[[0, 0.01],
                [dinrail_g+0.01,-dinrail_g],
                [dinrail_g,0.01], 
               ], 
          paths=[[0,1,2]]
          ); 
        }// fix part wedge     
        
      translate([dinrail_g/2-dinrail_w1/2,
                 0,
                 dinrail_h-dinholder_lever_cover/2+5/2*dinholder_fix_z-5/2*dinrail_t-5/2*dinrail_g
        ])
        cube([dinrail_g,
              dinholder_y,
              dinholder_fix_z+dinholder_lever_cover-dinrail_t-dinrail_g], center=true);  // fix part wedge support  
    
      for(i=[-1,1]){
        translate([(dinrail_w1+dinholder_x)/4+dinrail_g/2,
                   i*(dinholder_lever_wall  +dinrail_lever_w +dinholder_pass)/2,
                   dinrail_h-(dinrail_lever_h+dinholder_pass)/2])
        cube([(dinholder_x-dinrail_w1)/2-dinrail_g,
              dinholder_lever_wall-dinholder_pass,
          dinrail_lever_h+dinholder_pass],center=true);  // spring side walls
      }  
    }  
      
    translate([dinholder_x/2-2*s,
                0,            
                dinrail_h-(dinrail_lever_h+dinholder_pass)/2])
    cube([s+dinholder_pass,
           dinholder_y+olp,
           dinrail_lever_h+dinholder_pass+olp],
         center=true); // spring fixation cut  
    
    dinrail_screw(dinholder_x=dinholder_x,t=dinholder_pass);
  }
}

module dinrail_lever_holder(dinholder_x=100,s=2){
    echo("dinrail lever holder"); 
    
    difference(){
      translate([(dinrail_w1+dinholder_x)/4+dinrail_g/2,
                 0,
                 dinrail_h-(dinrail_lever_h+dinholder_pass+dinholder_z+dinholder_lever_cover+dinholder_bracket_z)/2])
        cube([(dinholder_x-dinrail_w1)/2-dinrail_g,
              dinholder_y,
              dinholder_z+dinholder_lever_cover+dinholder_bracket_z-dinrail_lever_h-dinholder_pass],
              center=true);  // main body
        
      dinrail_screw(dinholder_x=dinholder_x,t=dinholder_pass); 
  }
}

// s strengt of spring
// t pre-tension of spring
// n number of windings
module dinrail_lever(dinholder_x=100, s=2, t=0, n=2){
    echo("dinrail lever");
    translate([dinrail_w1/2-t,
               dinrail_lever_w/2,
               dinrail_h-dinrail_lever_h+ dinrail_lever_h- dinrail_t])
    rotate([90,0,0])
    linear_extrude(height=dinrail_lever_w){
        polygon(
        points=[[0+olp,               0                       ],
                [0+olp,               (dinrail_t-dinrail_lever_h) ],
                [-dinrail_lever_wedge,0            ],
             ], 
        paths=[[0,1,2]]
        );
    }// wedge
    
    translate([dinrail_w1/2+s-dinrail_g-t,
               -dinrail_lever_w/2,
               dinrail_h-dinrail_lever_h])
    cube([dinrail_g+t+olp,dinrail_lever_w,dinrail_lever_h]);  // tension an gap cube

    translate([dinrail_w1/2+s,
               dinrail_lever_w/2,
               dinrail_h-dinrail_lever_h])
    rotate([0,0,-90])
    spring(d=[dinrail_lever_w,
              (dinholder_x-dinrail_w1)/2-2.5*s,
              dinrail_lever_h],
              s=s,n=n); // spring
    
    for(i=[-1,1]){
        translate([dinholder_x/2-2*s,
                   i*(dinholder_y-dinholder_lever_wall)/2,
                   dinrail_h-dinrail_lever_h/2])
        cube([s,dinholder_lever_wall,dinrail_lever_h],center=true);
    }// hold back the spring  
}

if(show=="dinrail_bracket"){
  dinrail_bracket(dinholder_x=dinholder_x);
}
if(show=="print_dinrail_bracket"){
  rotate([180,0,0])dinrail_bracket(dinholder_x=dinholder_x);
}
if(show=="dinrail_lever_holder"){
  dinrail_lever_holder(dinholder_x=dinholder_x,s=s);
}
if(show=="print_dinrail_lever_holder"){
  rotate([180,0,0])dinrail_lever_holder(dinholder_x=dinholder_x,s=s);
}
if(show=="dinrail_lever"){
  dinrail_lever(dinholder_x=dinholder_x, s=s, t=t, n=n);
}
if(show=="assembly"){
    dinrail_bracket(dinholder_x=dinholder_x);
    dinrail_lever_holder(dinholder_x=dinholder_x,s=s);
    dinrail_lever(dinholder_x=dinholder_x, s=s, t=t, n=n);
}
