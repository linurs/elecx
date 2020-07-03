include <../bracket/bracket_dim.scad>
include <../module/module_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../wall/wall_dim.scad>

foot_gap=0.5;

foot_l2=2;
foot_l=module_l+2*foot_l2+foot_gap;
foot_l1=65;
foot_l3=foot_l2+bracket_h2+bracket_gap/2;
foot_l4=foot_l3+9;
foot_l5=(wall_l1-wall_l3)/2+foot_l3;

foot_h1=2;
foot_h2=1;
foot_h4=8+foot_h1;
foot_h=foot_h4-motherboard_z_offset; 
foot_h3=foot_h4-motherboard_z_offset+bracket_offset_z; 
foot_h5=foot_h4-motherboard_z_offset+bracket_offset_z-wall_w1;

foot_w2=2;
foot_w4=foot_w2+wall_h+bracket_w1;
foot_w5=wall_h+foot_w2;

function foot_w(n)=module_w(n)+n*bracket_gap+2*wall_h+2*foot_w2+foot_gap;
function foot_w1(n)=foot_w(n)-8;
function foot_w3(n)=motherboard_w(n)+foot_gap;

// bracket dimension for foot_type_bracket
foot_bracket_t=3;
foot_bracket_x=10;
foot_bracket_y=10;
foot_bracket_d=4;
foot_bracket_enforce_d=5;

foot_dh=8;
