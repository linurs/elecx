// linurs body
// ===========
// body lets create mode advanced bodies as the standard ones from OpenSCAD as cube, cylinder, sphere and polyhedron

center=true;
fn=16;

/* [prism] */
show_prism=false;
a_prism=[0,0];
b_prism=[10,0];
c_prism=[0,10];
h_prism=10;

/* [channel] */
show_channel=false;
d1_channel=1;
d2_channel=3;
h_channel=10;
a_channel=90;

/* [roundcube] */
show_roundcube=false;
// x,y,z
s_roundcube=[10,10,10]; 
r_roundcube=0.1; 

/* [spring] */
show_spring=false;
// x,y,z
d_spring=[10,25,1]; 
s_spring=2;
n_spring=2;

module prism(face=[[0,0],[1,0],[0,1]], h=1, center=false){  
  linear_extrude(height = h, center = center)
  polygon(points = [ face[0], face[1], face[2]], paths = [ [0, 1, 2]]);   
}

module roundcube(size=[1,1,1], r=0.1, center=false, $fn=8){
  t = center==true ? 0 : 1; 
  translate([size[0]/2*t,size[1]/2*t,size[2]/2*t])
  union(){
    cube(size=[size[0],size[1]-2*r,size[2]-2*r],center=true);
    cube(size=[size[0]-2*r,size[1],size[2]-2*r],center=true);
    cube(size=[size[0]-2*r,size[1]-2*r,size[2]],center=true);

    for(x=[-size[0]/2+r,size[0]/2-r]){
      for(y=[-size[1]/2+r,size[1]/2-r]){
        translate([x,y,0])
          cylinder(r=r,h=size[2]-2*r, center=true,$fn=$fn);   
      }
    }

    for(x=[-size[0]/2+r,size[0]/2-r]){
      for(z=[-size[2]/2+r,size[2]/2-r]){
        translate([x,0,z])
          rotate([90,0,0])
          cylinder(r=r,h=size[1]-2*r, center=true,$fn=$fn);   
      }
    }


    for(y=[-size[1]/2+r,size[1]/2-r]){
      for(z=[-size[2]/2+r,size[2]/2-r]){
        translate([0,y,z])
          rotate([0,90,0])
          cylinder(r=r,h=size[0]-2*r, center=true,$fn=$fn);   
      }
    }

    for(x=[-size[0]/2+r,size[0]/2-r]){
      for(y=[-size[1]/2+r,size[1]/2-r]){
        for(z=[-size[2]/2+r,size[2]/2-r]){
          translate([x,y,z])
            sphere(r=r, $fn=$fn);   
        }
      }
    }
  }
}

module channel(d1=1,d2=3,h=10,a=90, center=false, $fn=32){
   intersection(){     
            difference(){
                cylinder(d=d2,h=h,center=true,$fn=$fn);
                cylinder(d=d1,h=2*h,center=true,$fn=$fn);      
            }
            if((a<180)&&(a>0)){
               t=0.5*d2*tan(a/2); 
               linear_extrude(height=2*h, center = true){
                   polygon(points=[
                                  [0,0],
                                  [d2/2,t],
                                  [d2/2,-t]
                                  ], paths=[[0,1,2]]);       
                }
            }    
            else if(a==180){
               translate([0,d2/2,0])cube([d2/2,d2,2*h]); 
            }    
   }
}

module springelement(x=0, y=0, t=1, s=2, x1=0, y1=0, a=0, l=10, m=0, e=0){
    h=1.5*s/tan(a);
    mirror([m,0,0])translate([-x,y,0]){
        rotate([0,0,180])channel(d1=2,
                d2=3*s,
                h=t,
                a=180-2*a);
        if(e==0){
                translate([x1,y1,-t/2])rotate([0,0,a])cube([l,s,t]);
        }        
    }
}    

module spring(s=2,d=[10,10,1],n=2){
    r1=s/2;
    r2=1.5*s;
    
    xi=d.x-3*s; // inner x circle center x
    yi=(d.y-3*s)/n/2;     // inner x circle center x
         
    c=sqrt(pow(xi,2)+pow(yi,2)); // distance between center
    c1=c/(1+r2/r1); // where spring rod cuts line between the two circle centers
    l1=sqrt(pow(c1,2)-pow(r1,2));    
    c2=c-c1;
    l2=sqrt(pow(c2,2)-pow(r2,2));
    l=l1+l2;
    a1=atan(yi/xi);
    a2=acos(r1/c1);
    a3=180-a2-a1;
    a4=90-a3;
    x1=-r1*cos(a3);
    y1=r1*sin(a3);
    
 
    translate([1.5*s,1.5*s,d.z/2]){
    for(i=[0:n-1]){
           springelement(x=0,y=i*yi*2,s=s,t=d.z, x1=x1, y1=y1, a=a4, l=l, m=0);        
    }
    for(i=[0:n-1]){
           springelement(x=xi,y=(2*i+1)*yi,s=s, t=d.z, x1=x1, y1=y1, a=a4, l=l, m=1);        
    }
    springelement(x=0,y=d.y-3*s,s=s,t=d.z, x1=x1, y1=y1, a=a4, l=l, m=0, e=1);
    }
    for(i=[0,1]){
      translate([0,i*d.y,0])mirror([0,i,0])difference(){
          cube([d.x,1.5*s,d.z]);
          translate([1.5*s,1.5*s,0])cylinder(d=s,h=3*d.z,center=true,$fn=32);
      } 
    }    
}

if(show_prism==true){
   prism(h=h_prism,face=[a_prism,b_prism,c_prism],center=center); 
}

if(show_roundcube==true){
   roundcube(
    size=s_roundcube,
    center=center,
    r=r_roundcube, 
    $fn=fn);
}

if(show_channel==true){
  channel(
    d1=d1_channel,
    d2=d2_channel,
    h=h_channel,
    a=a_channel, 
    center=center, 
    $fn=fn);
}

if(show_spring==true){ 
    spring(d=d_spring,n=n_spring, s=s_spring);
}    
