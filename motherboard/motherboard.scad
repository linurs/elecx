// motherboard
// Motherboard of the elecbox
// This module is not intended to be 3D printed
include <motherboard_dim.scad>
use <motherboard_connector.scad>
use <../elecx_screw.scad>

module motherboard(n=1){
  echo("motherboard");  
  difference(){ 
    translate([0,
               0,
               -(pcbmodule_con_out+motherboard_con_out+motherboard_t)]){
      cube([motherboard_w,
            motherboard_con_t+step*(n-1),
            motherboard_t]); // the pcb
    }
    motherboard_screw(n=n,t=motherboard_pass);
  }
}

module motherboard_connectors(n=1, type=0){
  echo("motherboard connectors");  
  color("LightGrey")  
  translate([0,
             0,
             -(pcbmodule_con_out+motherboard_con_out+motherboard_t)]){
    
  for(i=[1:n]){  // add the connectors  
    translate([motherboard_w/2,
               motherboard_con_t/2+step*(i-1),
               motherboard_t+motherboard_con_h/2])
               motherboard_con(type=type);
      }
    }
}

module motherboard_assembled(n=1, type=0){
  echo("motherboard assembled");  
  motherboard(n=n);
  motherboard_connectors(n=n, type=type);  
}

n=2;

//
motherboard_assembled(n=n, type=0);

//motherboard_connectors(n=n, type=0);

//motherboard(n=n);
//motherboard(n=2, type=0);

// dummy to print out in case of n=1
//motherboard(n=1, type=1);
