
// motherboard pcb dimensions
motherboard_w=100;   // pcb width
motherboard_t=1.6;   // pcb thickness
motherboard_pass=0.5;// gap to fit screws 
step=25.4;           // distance between modules

// connector dimensions
motherboard_con_head_w=85;  // width of the connector head
motherboard_con_head_d=8.5; // depth of the connector head
motherboard_con_w=95;       // largest width of the connector
motherboard_con_h=11.6;     // largest height of the connector
motherboard_con_t=11;       // largest depth of the connector
motherboard_con_d_w=90;     // distance between mounting holes
motherboard_con_d=2.8;      // diameter of mounting holes
motherboard_con_out=5.2;    // height produced by the connector when pulgged in 

// pcb module connector dimension
pcbmodule_con_out=13-(5.3+2.8-2.54);  // distance connector sticks out of pcb

// offset
motherboard_z_offset= -(pcbmodule_con_out+motherboard_con_out+motherboard_t); // z offset motherboard built in
