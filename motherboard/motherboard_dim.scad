include<../library/din41612/connector_dim.scad>
// motherboard pcb dimensions
motherboard_w=100;   // pcb width
motherboard_t=1.6;   // pcb thickness
motherboard_pass=0.5;// gap to fit screws 
step=25.4;           // distance between modules



// offset
motherboard_z_offset= -(pcbmodule_con_out+motherboard_con_out+motherboard_t); // z offset motherboard built in
