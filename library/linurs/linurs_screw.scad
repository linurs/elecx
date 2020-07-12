// Metric screws and nuts 
// urs@linurs.org 2019
// It is targeted for 3D printing applications. 
// To look realistic is not the goal (Example: Nuts do not have a hole)

include <linurs_screw_dim.scad>

d=0; //[0:M2_5,1:M3,2:M4,3:M5]
type=0;//[0:head_cyl,1:head_cnt,2:head_no,3:head_hex]
w=15; 
i=10;
nut_sink=0;
screw_sink=0; 
t=0.01;
fn=16;

/* [hex_bolt] */
show_hex_bolt=false;

/* [nut] */
show_nut=false;

/* [screw] */
show_screw=false;

/* [screw_fix] */
show_screw_fix=false;

/* [screw_cut] */
show_screw_cut=false;

/* [nut_cut] */
show_nut_cut=false;
wi=0; 
rot=false;

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
module hex_bolt(d=M3, w=10, t=0)
{
  nutd=screw_hex[d][1]+t; // outer diameter of hex bolt
  cylinder(r=nutd/2,h=w+t, center=true,$fn=6); // nut
}

// nut 
module nut(d=M3, t=0)
{
  hex_bolt(d=d, w=nuth(d), t=t);    
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
module screw_fix(w=10, d=M3, type=head_cyl, screw_sink=0, nut_sink=0, t=0){
  screw(w=w, d=d, type=type, t=t);
  translate([0,0,-w/2+nuth(d)/2])
    nut(d=d,t=t);
  //additional material to be removed above the nut  
  translate([0,0,-(w+nut_sink)/2])hex_bolt(d=d,w=nut_sink+0.01,t=t);    
  //additional material to be removed above the screw head
  if(type==head_cnt){  
    translate([0,0,w/2+screw_sink])
    cylinder(d=screw_cnt[d][0]+t,h=screw_sink+0.01,center=true,$fn=16);
  }else{ 
    translate([0,0,(w+screw_sink)/2])
    cylinder(d=screw_cyl[d][0]+t,h=screw_sink+0.01,center=true,$fn=16);
  }     
}

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
module nut_cut(w=10, wi=0, d=M3, i=10, t=0, rot=false,type=head_cyl){ 
  r=(rot)?90:0;
  ds=(rot)?screw_hex[d][1]:screw_hex[d][0];
  rotate([0,0,r])nut(d,t);
  translate([i/2,0,0])
    cube([i,ds+t,nuth(d)+t],center=true);
  translate([0,0,-wi])
      if(type==head_cnt){    
          screw(w=w, d=d, type=type, t=t); 
        translate([0,0,w/2])
          cylinder(d=screw_cnt[d][0]+t,h=raise,center=true,$fn=16);
      }
      else{ 
          screw(w=w, d=d, type=type, t=t);   
  //      translate([0,0,0])
          //#cylinder(d=screw_cyl[d][0]+t,h=w,center=true,$fn=16);
      }       
}

if(show_hex_bolt==true){
   hex_bolt(d=d, w=w, t=t);
}

if(show_nut==true){
  nut(d=d, t=t);
}    

if(show_screw==true){
   screw(w=w, d=d, type=type, t=t);
}

if(show_screw_fix==true){
  screw_fix(w=w, d=d, type=type, nut_sink=nut_sink, screw_sink=screw_sink, t=t);
}

if(show_screw_cut==true){
  screw_cut(d=d,w=w,i=i,t=t,$fn=fn);
}    

if(show_nut_cut==true){
  nut_cut(w=w, wi=wi, d=d, i=i, t=t,rot=rot,type=type);
}  