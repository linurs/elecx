// Metric screws and nuts 
// urs@linurs.org 2019
// It is targeted for 3D printing applications. 
// To look realistic is not the goal (Example: Nuts do not have a hole)

include <linurs_screw_dim.scad>

// Changes
//2019-02-09 split in two files
//2017-05-19 bug fix hexbolt had wrong diameter
//2017-01-22 bug fix lentgh of hex scre is outer lenght as other screw types
//2017-01-06 added hex screw
//2015-10-12 added screw_cut
//2015-11-29 screw_fix parameter sunk added, and module hex_bolt

// Consistent parameters in this file
// d screw diameter M2_5, M3, ... (enumeration with screw_d)
// t millimeters added to diameters 
//   For the screw, head, nut = 0. 
//   For the piece where the screw, nut, ... passes through = 0.5 so it slides in well

// functions used multiple times to position nuts and heads
function headh_cyl(d)=screw_cyl[d][1];  // height of cyl screw head
function headh_cnt(d)=screw_cyl[d][1];  // height of cnt screw head
function headh(d,type=head_cyl)=(type==head_cyl ? headh_cyl(d) : (type==head_cnt ? headh_cnt(d) : 0 )); // height of screw head 

function nuth(d)=screw_hex[d][2];   // height of hex nut

// head of a cylinder screw
module screw_head_cyl(d=M3, t=0)
{
  screwhd=screw_cyl[d][0]+t; // diameter of cylinder screw head
  cylinder(d=screwhd,h=headh(d=d, type=head_cyl), center=true,$fn=16); // screw head
}

// head of a countersunk screw
module screw_head_cnt(d=M3, t=0)
{
  screwd=screw_d[d]+t; 
  screwhd=screw_cnt[d][0]+t; // diameter of cylinder screw head
  cylinder(d1=screwd,d2=screwhd,h=headh(d=d,type=head_cnt), center=true,$fn=16); // screw head
}

// head of a hex screw
module screw_head_hex(d=M3, t=0)
{
    translate([0,0,-nuth(d)/2])nut(d=d, t=t);
}

// head of all screws
module screw_head(d=M3, type=head_cyl, t=0)
{ 
  if(type==head_cnt){
    screw_head_cnt(d=d, t=t);
  } else {
    if(type==head_cyl){
      screw_head_cyl(d=d, t=t);
    } else {
       if(type==head_hex){
           screw_head_hex(d=d, t=t); 
       } 
    }    
  }
}

// hex bolt 
module hex_bolt(d=M3, h=10, t=0)
{
  nutd=screw_hex[d][1]+t; // outer diameter of hex bolt
  cylinder(r=nutd/2,h=h+t, center=true,$fn=6); // nut
}

// nut 
module nut(d=M3, t=0)
{
  hex_bolt(d=d, h=nuth(d), t=t);    
}

// screw 
// w outer width of the screw = screw length + head 
module screw(w=10, d=M3, type=head_cyl, t=0){
  screwd=screw_d[d]+t;       // screw diameter
  cylinder(d=screwd, h=w, center=true,$fn=16); // screw thread length
  translate([0,0,w/2-headh(d=d,type=type)/2])
  screw_head(d=d,type=type, t=t);
}

// screw fix
// w outer width of the screw = screw length + head 
// sink additional material below to remove 
// raise additional material above to remove
module screw_fix(w=10, d=M3, type=head_cyl, sink=0, raise=0, t=0){
  screw(w=w-sink*2, d=d, type=type, t=t);
  translate([0,0,-(w-sink*2)/2+nuth(d)/2])
    nut(d=d,t=t);
  //additional material to be removed above the nut  
  translate([0,0,-(w-sink+raise)/2])hex_bolt(d=d,h=sink+raise+0.01,t=t);    
  //additional material to be removed above the screw head
  if(type==head_cnt){  
    translate([0,0,(w-sink+raise)/2])
    cylinder(d=screw_cnt[d][0]+t,h=sink+raise+0.01,center=true,$fn=16);
  }else{ 
    translate([0,0,(w-sink+raise)/2])
    cylinder(d=screw_cyl[d][0]+t,h=sink+raise+0.01,center=true,$fn=16);
  }     
}
//screw_fix();
//translate([10,0,0])screw_fix(sink=2,type=head_cnt);
//

// screw cut
// material to be extracted from object to slide in a counter sunk screw for fixation
// w height of the cut out
// i depth of the screw
module screw_cut(d=M3,w=20,i=10,t=0,fn=32){
    hsh=screw_cnt[d][1];
    ws=screw_cnt[d][0]+t;
    ds=screw_d[d]+t;
    
    translate([i/2,0,-(w-hsh)/2])
      cube([i,ws,hsh],center=true);
    
    translate([0,0,-(w-hsh)/2])
      cylinder(d=ws,h=hsh,center=true,$fn=32);
    
    translate([0,0,-(w-hsh)/2+hsh])
        cylinder(d2=ds, d1=ws, h=hsh,center=true,$fn=fn);
    
    cylinder(h=w, d=ds, center=true, $fn=fn);   
    
    translate([i/2,0,0]) 
        cube([i,ds,w],center=true);
    
    for(y=[-1,1]){
        translate([i/2,y*ds/2,-w/2+hsh])
            rotate([45,0,0])
            cube([i,sqrt(2)*(ws-ds)/2,sqrt(2)*(ws-ds)/2],center=true);
    }
}
//screw_cut();

// nut cut
// material to be extracted from object to slide in a nut for fixation
// w height of the cylinder
// i lenght of the inlet
module nut_cut(w=10, wi=0, d=M3, i=10, t=0, raise=0, type=head_cyl){ 
  nut(d,t);
  translate([i/2,0,0])
    cube([i,screw_hex[d][0]+t,nuth(d)+t],center=true);
  translate([0,0,-wi])
      if(type==head_cnt){    
          screw(w=w, d=d, type=type, t=t); 
        translate([0,0,(w+raise)/2-0.01])
          cylinder(d=screw_cnt[d][0]+t,h=raise,center=true,$fn=16);
      }else{ 
          screw(w=w, d=d, type=type, t=t);   
        translate([0,0,(w+raise)/2-0.01])
          cylinder(d=screw_cyl[d][0]+t,h=raise,center=true,$fn=16);
      }       
}
//nut_cut(raise=2,type=head_cnt,i=14,w=20,wi=2, t=1);

// nut cut
// material to be extracted from object to slide in a nut for fixation
// w height of the cylinder
// i lenght of the inlet
module nut_cut_r(w=10, wi=0, d=M3, i=10, t=0, raise=0, type=head_cyl){ 
  rotate([0,0,90])nut(d,t);
  translate([i/2,0,0])
    cube([i,screw_hex[d][1]+t,nuth(d)+t],center=true);
  translate([0,0,-wi])
      if(type==head_cnt){    
          screw(w=w, d=d, type=type, t=t); 
        translate([0,0,(w+raise)/2-0.01])
          cylinder(d=screw_cnt[d][0]+t,h=raise,center=true,$fn=16);
      }else{ 
          screw(w=w, d=d, type=type, t=t);   
        translate([0,0,(w+raise)/2-0.01])
          cylinder(d=screw_cyl[d][0]+t,h=raise,center=true,$fn=16);
      }       
}
//nut_cut(raise=2,type=head_cnt,i=14,


// present the library
show=1;

if(show==1){
    grid=20;
    
    for (j=[0:10]){
        for (i=[0:3])
           translate([j*grid,i*grid,0]){  
           
    // elements           
           if(j==0){
             screw_fix(w=(i+2)*5,d=i, type=head_cyl, t=0);
           }
       
           if(j==1){
             nut(d=i,t=0);
           } 
       
           if(j==2){   
              screw(d=i,t=0);
           } 
           
           if(j==3){   
              screw(d=i,t=0,type=head_cnt);
           } 
           
           if(j==4){   
              screw(d=i,t=0,type=head_hex);
           } 
           
           if(j==5){   
              hex_bolt(d=i,t=0);
           } 
           
       }
    }   
     
    for (j=[0:2]){
        for (i=[0:3])
           translate([j*grid,-(i+1)*grid,0]){  
             difference(){
                cube([3*screw_d[i],3*screw_d[i],(i+2)*5-0.1],center=true);    
    
                if(j==0){
                  screw_fix(w=(i+2)*5,d=i,type=head_cnt, t=0.5);
                }   
                
                if(j==1){
                  nut_cut(d=i,w=(i+2)*5);
                }
                if(j==2){
                  screw_cut(d=1,w=(i+2)*5);
                }
            
             }
           }  
        
    }
}
   