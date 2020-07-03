// head
// ====
// the head of the elecx

// Variables for customizer
n=2;              // [1,2,3,4,5,6,7,8]
show="default";   // ["default","2d","xcut","ycut","print"]
vent=false;
head_vent_x=2;
head_vent_y=6;
head_vent_n=7;
brand=false;

include <../library/linurs/linurs_screw_dim.scad>
include <../elecx_dim.scad>
include <head_dim.scad>

use <../library/linurs/linurs_screw.scad>

module head(n=1,vent=0, brand=0, top=0){
    echo("head");
    difference(){
        union(){// adding material
            translate([0,0,head_h2/2])
            cube([head_l,head_w(n),head_h2],center=true);  // head top
            
            for(i=[-1,1]){
                translate([0,i*(head_w(n)-head_w1)/2,head_h/2])
                cube([head_l,head_w1,head_h],center=true); // y side walls
            }
            
            for(i=[-1,1]){
                translate([i*(head_l-head_l1)/2,0,head_h/2])
                cube([head_l1,head_w(n),head_h],center=true); // x side walls
            }
            
            for(i=[-1,1]){
                translate([0,i*(head_w(n)-head_w2)/2,head_h1/2])
                cube([head_l,head_w2,head_h1],center=true); // y side walls stand
            }
            
            for(i=[-1,1]){
                translate([i*(head_l-head_l2)/2,0,head_h1/2])
                cube([head_l2,head_w(n),head_h1],center=true); // x side walls stand
            }       
          
            for(i=[-1,1]){
                translate([0,i*((head_w(n)-head_w3)/2-head_w2),head_h/2])
                cube([head_l3,head_w3,head_h],center=true); // wall fixation
            }       
        }// removing material 
        for(i=[-1,1]){
            translate([0,
                       i*(head_w(n)/2-head_w1-wall_hd1),
                       head_h/2+head_h2])
            rotate([0,0,i*-90])
            nut_cut(w=head_h, 
                    wi=0, 
                    d=wall_d1, 
                    i=head_w3, 
                    t=head_gap,
                    rot=true,
                    type=head_no);
        }       

        if(vent==true){
          head_lv_start=head_l3/2+head_vent_x/2;
          head_lv_stop=head_l/2-head_l2-head_vent_x/2;
            
          for(k=[-1,1]){  
              for(j=[0:head_vent_n]){
                 x=k*(head_lv_start+j*(head_lv_stop-head_lv_start)/head_vent_n);
                 echo(j,x);
                 for(i=[0:n-1]){
                   y=i*step-(n-1)*step/2;  
                   translate([x,y,0])
                    cube([head_vent_x,
                           step-head_vent_y,
                           2*head_h],center=true);
                }
              }
          }
        }
        
        if(brand==true){         
         translate([0,0,head_h1/2])
         rotate([0,180,90])
         linear_extrude(height = head_h1 ) {
         text(branding, 
             font = "Liberation Sans:style=Bold Italic",
             halign = "center",
             valign = "center",
             size=10);
         }
        }        
    }        
}

if(show=="default"){
     head(n=n, vent=vent, brand=brand);
}

if(show=="print"){
   head(n=n, vent=vent, brand=brand);
}

if(show=="2d"){
  rotate([0,180,0])
     translate([-50,-21,-85])
     head(n=n, vent=vent, brand=brand);
}

if(show=="xcut"){
  difference(){ 
   rotate([0,180,0])
     translate([-50,-21,-85])
       head(n=n, vent=vent, brand=brand);
    translate([-100,0,-50])
      cube([200,100,100]);  
  }    
}

if(show=="ycut"){
  difference(){ 
    rotate([0,180,0])
     translate([-50,-21,-85])
       head(n=n, vent=vent, brand=brand);
    translate([-100,-100,-50])
      cube([100,200,100]);  
  }    
}
