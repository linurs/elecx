// bracket

include <../pcb/pcb_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

bracket_screw=M2_5;   // hole for the screw

bracket_gap=0.5;      // gap between bracket to make sure it fits in the box
bracket_screw_gap=0.5;// gap to fit the screw

bracket_l=pcb_w+15;   // height of bracket
bracket_l1=19;        // hole l
bracket_l2=3*screw_d[bracket_screw];
bracket_ld=pcb_wd;    // hole distance

bracket_h=10;         // depth of the U shape at the side of the screw
bracket_h1=4;         // depth of the U shape at the side where no screw is 
bracket_h2=2-bracket_gap/2;   // thickness of bracket
bracket_h3=5;         // hole h

bracket_w1=4;         // height of the mounting hole cube
bracket_tn=2;         // thickness of bracket
bracket_t=bracket_tn-bracket_gap/2;  // thickness of bracket - gap

bracket_offset_z=-10;  // bracket offset in elecbox z axis

function bracket_w(n)=step*n-bracket_gap;
function bracket_w2(n)=step*n-2*bracket_tn;