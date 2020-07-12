// pcb
// ===
// The pcb is the master object and has its 
// lower left corner solder side at the origin of the 
// coordinate system 

n=2;  // [1,2,3,4,5,6,7,8]
show_pcb="assemblies"; // [assemblies,assembly,pcb]

include <pcb_dim.scad>
include <../motherboard/motherboard_dim.scad>

use <../library/din41612/din41612_male.scad>

module pcb(){
  echo("pcb");  
  color("greenyellow")
  difference(){
    cube([pcb_l,pcb_h,pcb_w]); // pcb
    for(x=[-1,1]){ // mounting holes
      for(y=[pcb_wd1,pcb_wd1+pcb_wd]){
        translate([x*pcb_ld/2+pcb_l/2,0,y])
        rotate([90,0,0])
        cylinder(d=pcb_d,h=3*pcb_h,center=true,$fn=16);
      }
    }
  }
}

module pcb_assembly(){
  echo("pcb assembly");  
  pcb();  
  translate([pcb_l/2,pcb_h,0])  
  rotate([-90,0,0])din41612_male();  
}

module pcb_assemblies(n=1){
  echo("pcb assemblies"); 
  for(i=[0:n-1]){ // add the connectors
      echo(i);
      translate([0,step*i,0])
      pcb_assembly();
  }    
}    

if(show_pcb=="assemblies"){
  pcb_assemblies(n=n);
}

if(show_pcb=="assembly"){
  pcb_assembly();
}

if(show_pcb=="pcb"){
    // Move to center to create 2D drawings from top view 
    // with script OpenSCAD22d.py
    //
    rotate([90,0,180])
    //
    translate([-pcb_l/2,-pcb_h/2,-pcb_w/2])
    pcb();
}