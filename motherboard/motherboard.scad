// Motherboard of the elecbox
// This module is not intended to be 3D printed
include <motherboard_dim.scad>
include <../library/din41612/connector_dim.scad>

use <../library/din41612/connector.scad>
use <../library/linurs/linurs_screw.scad>
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
                     motherboard_t])
     motherboard_con(type=type);
    }
  }
}

module motherboard_assembled(n=1, type=0){
  echo("motherboard assembled");  
  motherboard(n=n);
  motherboard_connectors(n=n, type=type);  
}

module motherboard_codes(n=1, type=0){
  echo("motherboard codings");  
  color("LightGrey")  
  translate([0,
                   0,
                  -(pcbmodule_con_out+motherboard_con_out+motherboard_t)])  
  for(i=[1:n]){  // add the connectors  
      translate([motherboard_w/2,
                       motherboard_con_t/2+step*(i-1)+step/2,
                       motherboard_t])
                  
      motherboard_con(type=2,code=code,code_str=code_str);
  }
}

module connectors(n=1){
  echo("pcb connectors");  
  color("LightGrey")  
  translate([(motherboard_w-con_w)/2,0,-pcbmodule_con_out])  
  for(i=[1:n]){  // add the connectors  
        translate([0,
                         step*(i-1),
                         0])
        connector();  
  }
}

module pcb_codes(n=1){
  echo("pcb connectors");  
  color("LightGrey")  
      translate([(motherboard_w-con_w)/2,0,-pcbmodule_con_out])  
  for(i=[1:n]){  // add the connectors  
          translate([0,
                     step*(i-1)+step/2,
                     0])
       connector(type=1, code=code,code_str=code_str);  
      }
}

n=2;
code=0;
code_str=str(pow(2,14));

//connectors(n=n); 
//pcb_codes(n=n); 
//motherboard_connectors(n=n, type=0);
//motherboard_codes(n=n, type=0);
//motherboard(n=n);

//
motherboard_assembled(n=n, type=1);
