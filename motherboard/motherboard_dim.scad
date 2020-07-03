include <../library/linurs/linurs_screw_dim.scad>
include <../library/din41612/din41612_female_dim.scad>
include <../library/din41612/din41612_male_dim.scad>
include <../pcb/pcb_dim.scad>
// motherboard pcb dimensions
motherboard_l=pcb_l;   // pcb width
motherboard_h=1.6;     // pcb thickness
step=25.4;             // distance between modules

function motherboard_w(n)=din41612_female_w+step*(n-1);

screw_motherboard_d=M2_5;
screw_motherboard_l=16;
motherboard_pass=0.5;// gap to fit screws 

motherboard_z_offset=-din41612_male_w1-din41612_female_h1-motherboard_h;

